//
//  TodoRepositoryProtocol.swift
//  Tuttu
//
//  Created by Marco Antonio Landauro Alba on 16/11/25.
//

import Foundation

public protocol TodoRepositoryProtocol {
    /// Devuelve todos los Todo guardados, en el orden definido por la implementación.
    func fetchAll() async throws(TodoRepositoryError) -> [Todo] // throws TodoRepositoryError

    /// Obtiene un Todo específico.
    func get(by id: UUID) async throws(TodoRepositoryError) -> Todo // throws TodoRepositoryError.notFound

    /// Crea un nuevo Todo.
    func create(_ todo: Todo) async throws(TodoRepositoryError) // throws TodoRepositoryError

    /// Actualiza un Todo existente.
    func update(_ todo: Todo) async throws(TodoRepositoryError) // throws TodoRepositoryError.notFound / .duplicate / etc.

    /// Elimina un Todo por id.
    func delete(id: UUID) async throws(TodoRepositoryError) // throws TodoRepositoryError.notFound
}
