//
//  FileTodoLocalDataSource.swift
//  Tuttu
//
//  Created by Marco Antonio Landauro Alba on 16/11/25.
//

import Foundation
import SwiftData

@MainActor
public final class SwiftDataTodoLocalDataSource: TodoLocalDataSourceProtocol {

    private let context: ModelContext

    public init(context: ModelContext) {
        self.context = context
    }

    // MARK: - TodoLocalDataSource

    public func fetchAll() async throws(TodoRepositoryError) -> [TodoDTO] {
        do {
            let descriptor = FetchDescriptor<TodoObject>(
                sortBy: [SortDescriptor(\.createdAt, order: .forward)]
            )
            let objects = try context.fetch(descriptor)
            return objects.map { $0.toDTO() }
        } catch {
            throw TodoRepositoryError.persistenceFailure(
                message: "Error al leer datos de SwiftData: \(error.localizedDescription)"
            )
        }
    }

    public func saveAll(_ todos: [TodoDTO]) async throws(TodoRepositoryError) {
        do {
            // 1. Borramos todos los existentes
            let descriptor = FetchDescriptor<TodoObject>()
            let existing = try context.fetch(descriptor)
            existing.forEach { context.delete($0) }

            // 2. Insertamos los nuevos
            for dto in todos {
                let obj = TodoObject(dto: dto)
                context.insert(obj)
            }

            try context.save()
        } catch {
            throw TodoRepositoryError.persistenceFailure(
                message: "Error al guardar todos los datos en SwiftData: \(error.localizedDescription)"
            )
        }
    }

    public func create(_ todo: TodoDTO) async throws(TodoRepositoryError) {
        do {
            // Clonamos el id a una constante local Sendable
            let id = todo.id
            
            let descriptor = FetchDescriptor<TodoObject>(
                predicate: #Predicate { object in
                    object.id == id
                }
            )
            
            let existing = try context.fetch(descriptor)
            if !existing.isEmpty {
                let uuid = UUID(uuidString: id) ?? UUID()
                throw TodoRepositoryError.duplicate(id: uuid)
            }
            
            let object = TodoObject(dto: todo)
            context.insert(object)
            try context.save()
            
        } catch let repoError as TodoRepositoryError {
            throw repoError
        } catch {
            throw TodoRepositoryError.persistenceFailure(
                message: "Error al crear Todo en SwiftData: \(error.localizedDescription)"
            )
        }
    }

    public func update(_ todo: TodoDTO) async throws(TodoRepositoryError) {
        do {
            // 👇 copiar el id a una constante local
            let id = todo.id

            let descriptor = FetchDescriptor<TodoObject>(
                predicate: #Predicate<TodoObject> { object in
                    object.id == id
                }
            )

            guard let object = try context.fetch(descriptor).first else {
                let uuid = UUID(uuidString: id) ?? UUID()
                throw TodoRepositoryError.notFound(id: uuid)
            }

            object.title = todo.title
            object.note = todo.note
            object.isCompleted = todo.isCompleted
            object.createdAt = todo.createdAt
            object.updatedAt = todo.updatedAt

            try context.save()
        } catch let repoError as TodoRepositoryError {
            throw repoError
        } catch {
            throw TodoRepositoryError.persistenceFailure(
                message: "Error al actualizar Todo en SwiftData: \(error.localizedDescription)"
            )
        }
    }

    public func delete(id: String) async throws(TodoRepositoryError) {
        do {
            let localId = id

            let descriptor = FetchDescriptor<TodoObject>(
                predicate: #Predicate<TodoObject> { object in
                    object.id == localId
                }
            )

            guard let object = try context.fetch(descriptor).first else {
                let uuid = UUID(uuidString: localId) ?? UUID()
                throw TodoRepositoryError.notFound(id: uuid)
            }

            context.delete(object)
            try context.save()
        } catch let repoError as TodoRepositoryError {
            throw repoError
        } catch {
            throw TodoRepositoryError.persistenceFailure(
                message: "Error al eliminar Todo en SwiftData: \(error.localizedDescription)"
            )
        }
    }
}
