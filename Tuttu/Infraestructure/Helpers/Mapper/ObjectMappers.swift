//
//  ObjectMappers.swift
//  Tuttu
//
//  Created by Marco Antonio Landauro Alba on 16/11/25.
//

import Foundation

public extension TodoObject {
    convenience init(dto: TodoDTO) {
        self.init(
            id: dto.id,
            title: dto.title,
            note: dto.note,
            isCompleted: dto.isCompleted,
            createdAt: dto.createdAt,
            updatedAt: dto.updatedAt
        )
    }

    @MainActor
    func toDTO() -> TodoDTO {
        TodoDTO(
            id: id,
            title: title,
            note: note,
            isCompleted: isCompleted,
            createdAt: createdAt,
            updatedAt: updatedAt
        )
    }
}
