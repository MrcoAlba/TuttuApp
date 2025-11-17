//
//  TodoUseCases.swift
//  Tuttu
//
//  Created by Marco Antonio Landauro Alba on 16/11/25.
//

import Foundation

public protocol FetchTodosUseCase {
    /// Obtiene todos los Todos.
    func execute() async throws(TodoUseCaseError) -> [Todo]
}

public protocol CreateTodoUseCase {
    /// Crea un nuevo Todo a partir de un título y una nota opcional.
    @discardableResult
    func execute(title: String, note: String?) async throws(TodoUseCaseError) -> Todo
}

public protocol UpdateTodoUseCase {
    /// Actualiza un Todo existente (título/nota, y potencialmente otros campos en el futuro).
    @discardableResult
    func execute(
        id: UUID,
        title: String,
        note: String?
    ) async throws(TodoUseCaseError) -> Todo
}

public protocol ToggleTodoCompletionUseCase {
    /// Cambia el estado isCompleted de un Todo (pendiente <-> completado).
    @discardableResult
    func execute(id: UUID) async throws(TodoUseCaseError) -> Todo
}

public protocol DeleteTodoUseCase {
    /// Elimina el Todo con el id dado.
    func execute(id: UUID) async throws(TodoUseCaseError)
}
