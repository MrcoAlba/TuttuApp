//
//  TodoLocalDataSource.swift
//  Tuttu
//
//  Created by Marco Antonio Landauro Alba on 16/11/25.
//

import Foundation

/// Fuente de datos local para Todos.
/// Infraestructura implementa este protocolo (JSON, CoreData, UserDefaults, etc.)
public protocol TodoLocalDataSourceProtocol {
    /// Devuelve todos los TodoDTO almacenados.
    /// - Throws: `TodoRepositoryError` mapeado por la implementación concreta.
    func fetchAll() async throws(TodoRepositoryError) -> [TodoDTO]

    /// Persiste la colección completa de Todos.
    /// Puede usarse como mecanismo centralizado de guardado (p.ej. sobrescribir archivo).
    /// - Throws: `TodoRepositoryError`
    func saveAll(_ todos: [TodoDTO]) async throws(TodoRepositoryError)

    /// Crea un nuevo TodoDTO.
    /// - Throws: `TodoRepositoryError`
    func create(_ todo: TodoDTO) async throws(TodoRepositoryError)

    /// Actualiza un TodoDTO existente.
    /// - Throws: `TodoRepositoryError`
    func update(_ todo: TodoDTO) async throws(TodoRepositoryError)

    /// Elimina un TodoDTO por id.
    /// - Throws: `TodoRepositoryError`
    func delete(id: String) async throws(TodoRepositoryError)
}
