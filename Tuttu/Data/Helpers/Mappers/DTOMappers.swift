//
//  DTOMappers.swift
//  Tuttu
//
//  Created by Marco Antonio Landauro Alba on 16/11/25.
//

import Foundation

public extension TodoDTO {
    init(domain: Todo) {
        self.id = domain.id.uuidString
        self.title = domain.title
        self.note = domain.note
        self.isCompleted = domain.isCompleted
        self.createdAt = domain.createdAt
        self.updatedAt = domain.updatedAt
    }

    func toDomain() -> Todo {
        Todo(
            id: UUID(uuidString: id) ?? UUID(),
            title: title,
            note: note,
            isCompleted: isCompleted,
            createdAt: createdAt,
            updatedAt: updatedAt
        )
    }
}
