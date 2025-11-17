//
//  FetchTodosUseCaseImpl.swift
//  Tuttu
//
//  Created by Marco Antonio Landauro Alba on 16/11/25.
//

import Foundation

public final class FetchTodosUseCaseImpl: FetchTodosUseCase {

    private let repository: TodoRepositoryProtocol

    public init(repository: TodoRepositoryProtocol) {
        self.repository = repository
    }

    public func execute() async throws(TodoUseCaseError) -> [Todo] {
        do {
            return try await repository.fetchAll()
        } catch {
            throw TodoUseCaseErrorMapper.mapRepositoryError(error)
        }
    }
}
