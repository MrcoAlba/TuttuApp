//
//  ToggleTodoCompletionUseCaseImpl.swift
//  Tuttu
//
//  Created by Marco Antonio Landauro Alba on 16/11/25.
//

import Foundation

public final class ToggleTodoCompletionUseCaseImpl: ToggleTodoCompletionUseCase {

    private let repository: TodoRepositoryProtocol

    public init(repository: TodoRepositoryProtocol) {
        self.repository = repository
    }

    @discardableResult
    public func execute(id: UUID) async throws(TodoUseCaseError) -> Todo {
        do {
            // 1. Obtenemos el Todo actual
            let existing = try await repository.get(by: id)

            // 2. Invertimos el estado de completado
            var updated = existing
            updated.isCompleted.toggle()
            updated.updatedAt = Date()

            // 3. Persistimos
            try await repository.update(updated)
            return updated

        } catch {
            throw TodoUseCaseErrorMapper.mapRepositoryError(error)
        }
    }
}
