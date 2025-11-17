//
//  TodoRepositoryImpl.swift
//  Tuttu
//
//  Created by Marco Antonio Landauro Alba on 16/11/25.
//

import Foundation

public final class TodoRepositoryImpl: TodoRepositoryProtocol {

    private let localDataSource: TodoLocalDataSourceProtocol

    public init(localDataSource: TodoLocalDataSourceProtocol) {
        self.localDataSource = localDataSource
    }

    // MARK: - TodoRepository

    public func fetchAll() async throws(TodoRepositoryError) -> [Todo] {
        let dtos = try await localDataSource.fetchAll()
        return dtos.map { $0.toDomain() }
    }

    public func get(by id: UUID) async throws(TodoRepositoryError) -> Todo {
        let dtos = try await localDataSource.fetchAll()
        guard let dto = dtos.first(where: { $0.id == id.uuidString }) else {
            throw TodoRepositoryError.notFound(id: id)
        }
        return dto.toDomain()
    }

    public func create(_ todo: Todo) async throws(TodoRepositoryError) {
        let dto = TodoDTO(domain: todo)
        try await localDataSource.create(dto)
    }

    public func update(_ todo: Todo) async throws(TodoRepositoryError) {
        let dto = TodoDTO(domain: todo)
        try await localDataSource.update(dto)
    }

    public func delete(id: UUID) async throws(TodoRepositoryError) {
        try await localDataSource.delete(id: id.uuidString)
    }
}
