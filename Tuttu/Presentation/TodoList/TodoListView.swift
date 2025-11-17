//
//  TodoListView.swift
//  Tuttu
//
//  Created by Marco Antonio Landauro Alba on 16/11/25.
//

import SwiftUI

struct TodoListView: View {

    @State private var screenState: TodoListScreenState

    let fetchTodosUseCase: FetchTodosUseCase
    let createTodoUseCase: CreateTodoUseCase
    let updateTodoUseCase: UpdateTodoUseCase
    let toggleTodoCompletionUseCase: ToggleTodoCompletionUseCase
    let deleteTodoUseCase: DeleteTodoUseCase

    @State private var showingEditor = false
    @State private var todoToEdit: Todo? = nil

    init(
        screenState: TodoListScreenState,
        fetchTodosUseCase: FetchTodosUseCase,
        createTodoUseCase: CreateTodoUseCase,
        updateTodoUseCase: UpdateTodoUseCase,
        toggleTodoCompletionUseCase: ToggleTodoCompletionUseCase,
        deleteTodoUseCase: DeleteTodoUseCase
    ) {
        _screenState = State(initialValue: screenState)
        self.fetchTodosUseCase = fetchTodosUseCase
        self.createTodoUseCase = createTodoUseCase
        self.updateTodoUseCase = updateTodoUseCase
        self.toggleTodoCompletionUseCase = toggleTodoCompletionUseCase
        self.deleteTodoUseCase = deleteTodoUseCase
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(screenState.items) { todo in
                    HStack {
                        Button {
                            toggleCompletion(todo)
                        } label: {
                            Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
                                .foregroundStyle(todo.isCompleted ? .green : .gray)
                        }

                        VStack(alignment: .leading) {
                            Text(todo.title)
                                .strikethrough(todo.isCompleted)
                            if let note = todo.note, !note.isEmpty {
                                Text(note)
                                    .font(.footnote)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .onTapGesture {
                            todoToEdit = todo
                            showingEditor = true
                        }
                    }
                }
                .onDelete { indexSet in
                    indexSet.forEach { idx in
                        let todo = screenState.items[idx]
                        delete(todo)
                    }
                }
                .onMove { indices, newOffset in
                    
                }
            }
            .navigationTitle("Tuttu")
            .toolbar {
                Button {
                    todoToEdit = nil
                    showingEditor = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .task { await load() }
            .sheet(isPresented: $showingEditor) {
                TodoEditorView(
                    todo: todoToEdit,
                    onSave: { title, note in
                        Task {
                            if let t = todoToEdit {
                                try await updateTodoUseCase.execute(id: t.id, title: title, note: note)
                            } else {
                                _ = try await createTodoUseCase.execute(title: title, note: note)
                            }
                            await load()
                        }
                    }
                )
            }
        }
    }

    // MARK: - Actions

    @MainActor
    private func load() async {
        screenState.isLoading = true
        do {
            screenState.items = try await fetchTodosUseCase.execute()
        } catch {
            screenState.errorMessage = "Error al cargar"
        }
        screenState.isLoading = false
    }

    private func toggleCompletion(_ todo: Todo) {
        Task {
            do {
                _ = try await toggleTodoCompletionUseCase.execute(id: todo.id)
                await load()
            } catch {
                // manejar error si deseas
            }
        }
    }

    private func delete(_ todo: Todo) {
        Task {
            do {
                try await deleteTodoUseCase.execute(id: todo.id)
                await load()
            } catch {
                // manejar error
            }
        }
    }
}
