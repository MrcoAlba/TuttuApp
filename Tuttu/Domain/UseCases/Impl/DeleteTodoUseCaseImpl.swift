//
//  DeleteTodoUseCaseImpl.swift
//  Tuttu
//
//  Created by Marco Antonio Landauro Alba on 16/11/25.
//

import Foundation

public final class DeleteTodoUseCaseImpl: DeleteTodoUseCase {

    private let repository: TodoRepositoryProtocol

    public init(repository: TodoRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(id: UUID) async throws(TodoUseCaseError) {
        do {
            try await repository.delete(id: id)
        } catch {
            throw TodoUseCaseErrorMapper.mapRepositoryError(error)
        }
    }
}
