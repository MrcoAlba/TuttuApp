//
//  TuttuCompositionRoot.swift
//  Tuttu
//
//  Created by Marco Antonio Landauro Alba on 16/11/25.
//

import Foundation
import SwiftData
import SwiftUI

public struct TuttuCompositionRoot {

    // Casos de uso expuestos a las Views
    public let fetchTodosUseCase: FetchTodosUseCase
    public let createTodoUseCase: CreateTodoUseCase
    public let updateTodoUseCase: UpdateTodoUseCase
    public let toggleTodoCompletionUseCase: ToggleTodoCompletionUseCase
    public let deleteTodoUseCase: DeleteTodoUseCase

    public init(context: ModelContext) {
        // Infra
        let localDataSource = SwiftDataTodoLocalDataSource(context: context)

        // Data
        let repository = TodoRepositoryImpl(localDataSource: localDataSource)

        // Dominio
        let validator = TodoValidator()
        self.fetchTodosUseCase = FetchTodosUseCaseImpl(repository: repository)
        self.createTodoUseCase = CreateTodoUseCaseImpl(repository: repository, validator: validator)
        self.updateTodoUseCase = UpdateTodoUseCaseImpl(repository: repository, validator: validator)
        self.toggleTodoCompletionUseCase = ToggleTodoCompletionUseCaseImpl(repository: repository)
        self.deleteTodoUseCase = DeleteTodoUseCaseImpl(repository: repository)
    }

    // Factory para el estado de la pantalla
    private func makeTodoListScreenState() -> TodoListScreenState {
        TodoListScreenState()
    }

    // Factory para la vista principal de ToDos
    public func makeTodoListView() -> some View {
        TodoListView(
            screenState: makeTodoListScreenState(),
            fetchTodosUseCase: fetchTodosUseCase,
            createTodoUseCase: createTodoUseCase,
            updateTodoUseCase: updateTodoUseCase,
            toggleTodoCompletionUseCase: toggleTodoCompletionUseCase,
            deleteTodoUseCase: deleteTodoUseCase
        )
    }
}
