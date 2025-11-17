//
//  TodoValidationError.swift
//  Tuttu
//
//  Created by Marco Antonio Landauro Alba on 16/11/25.
//

import Foundation

public enum TodoValidationError: Error, Equatable {
    /// El título está vacío o solo tiene espacios.
    case emptyTitle

    /// El título excede un máximo permitido.
    case titleTooLong(maxLength: Int)

    /// La nota excede un máximo permitido.
    case noteTooLong(maxLength: Int)
}
