//
//  CreateTodoUseCaseImpl.swift
//  Tuttu
//
//  Created by Marco Antonio Landauro Alba on 16/11/25.
//

import Foundation

public final class CreateTodoUseCaseImpl: CreateTodoUseCase {

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
    public func execute(title: String, note: String?) async throws(TodoUseCaseError) -> Todo {
        // 1. Validación
        do {
            try validator.validateTitle(title)
            try validator.validateNote(note)
        } catch let validationError as TodoValidationError {
            throw TodoUseCaseError.validation(validationError)
        } catch {
            // Si llega algo raro por acá, lo tratamos como unknown de repositorio
            throw TodoUseCaseError.repository(.unknown)
        }

        // 2. Construimos la entidad de dominio
        let todo = Todo(
            title: title.trimmingCharacters(in: .whitespacesAndNewlines),
            note: note,
            isCompleted: false,
            createdAt: Date(),
            updatedAt: nil
        )

        // 3. Persistimos
        do {
            try await repository.create(todo)
            return todo
        } catch {
            throw TodoUseCaseErrorMapper.mapRepositoryError(error)
        }
    }
}
