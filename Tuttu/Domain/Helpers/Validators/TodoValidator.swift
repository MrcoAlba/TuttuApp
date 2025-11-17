//
//  TodoValidator.swift
//  Tuttu
//
//  Created by Marco Antonio Landauro Alba on 16/11/25.
//

import Foundation

public protocol TodoValidating {
    func validateTitle(_ title: String) throws
    func validateNote(_ note: String?) throws
}

public struct TodoValidator: TodoValidating {

    public let maxTitleLength: Int
    public let maxNoteLength: Int

    public init(
        maxTitleLength: Int = 200,
        maxNoteLength: Int = 1_000
    ) {
        self.maxTitleLength = maxTitleLength
        self.maxNoteLength = maxNoteLength
    }

    public func validateTitle(_ title: String) throws(TodoValidationError) {
        let trimmed = title.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !trimmed.isEmpty else {
            throw .emptyTitle
        }

        guard trimmed.count <= maxTitleLength else {
            throw .titleTooLong(maxLength: maxTitleLength)
        }
    }

    public func validateNote(_ note: String?) throws(TodoValidationError) {
        guard let note, !note.isEmpty else { return }

        guard note.count <= maxNoteLength else {
            throw .noteTooLong(maxLength: maxNoteLength)
        }
    }
}
