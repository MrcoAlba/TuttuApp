//
//  Todo.swift
//  Tuttu
//
//  Created by Marco Antonio Landauro Alba on 16/11/25.
//

import Foundation

public struct Todo: Identifiable, Equatable {
    public let id: UUID
    public var title: String
    public var note: String?
    public var isCompleted: Bool
    public let createdAt: Date
    public var updatedAt: Date?

    public init(
        id: UUID = UUID(),
        title: String,
        note: String? = nil,
        isCompleted: Bool = false,
        createdAt: Date = Date(),
        updatedAt: Date? = nil
    ) {
        self.id = id
        self.title = title
        self.note = note
        self.isCompleted = isCompleted
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
