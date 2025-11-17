//
//  TodoDTO.swift
//  Tuttu
//
//  Created by Marco Antonio Landauro Alba on 16/11/25.
//

import Foundation

public struct TodoDTO: Codable, Equatable, Identifiable, Sendable {
    public let id: String
    public var title: String
    public var note: String?
    public var isCompleted: Bool
    public var createdAt: Date
    public var updatedAt: Date?

    public init(
        id: String,
        title: String,
        note: String?,
        isCompleted: Bool,
        createdAt: Date,
        updatedAt: Date?
    ) {
        self.id = id
        self.title = title
        self.note = note
        self.isCompleted = isCompleted
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
