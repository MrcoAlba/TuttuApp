//
//  UpdateTodoUseCaseImpl.swift
//  Tuttu
//
//  Created by Marco Antonio Landauro Alba on 16/11/25.
//

import Foundation

public final class UpdateTodoUseCaseImpl: UpdateTodoUseCase {

    private let repository: TodoRepositoryProtocol
    private let validator: TodoValidating

    public init(
        repository: TodoRepositoryProtocol,
        validator: TodoValidating = TodoValidator()
    ) {
        self.repository = repository
        self.validator = validator
    }

    @discardableResult
    public func execute(
        id: UUID,
        title: String,
        note: String?
    ) async throws(TodoUseCaseError) -> Todo {
        // 1. Validación
        do {
            try validator.validateTitle(title)
            try validator.validateNote(note)
        } catch let validationError as TodoValidationError {
            throw TodoUseCaseError.validation(validationError)
        } catch {
            throw TodoUseCaseError.repository(.unknown)
        }

        do {
            // 2. Obtenemos la versión actual
            let existing = try await repository.get(by: id)

            // 3. Creamos una nueva instancia con los cambios
            var updated = existing
            updated.title = title.trimmingCharacters(in: .whitespacesAndNewlines)
            updated.note = note
            updated.updatedAt = Date()

            // 4. Guardamos en el repo
            try await repository.update(updated)
            return updated

        } catch {
            throw TodoUseCaseErrorMapper.mapRepositoryError(error)
        }
    }
}
