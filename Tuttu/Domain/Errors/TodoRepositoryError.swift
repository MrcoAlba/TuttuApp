//
//  TodoRepositoryError.swift
//  Tuttu
//
//  Created by Marco Antonio Landauro Alba on 16/11/25.
//

import Foundation

public enum TodoRepositoryError: Error, Equatable {
    /// No se encontró un Todo con el id indicado.
    case notFound(id: UUID)

    /// Ya existe un Todo con el mismo id (colisión/duplicado).
    case duplicate(id: UUID)

    /// Error al persistir datos (disco/codificación/etc.).
    case persistenceFailure(message: String?)

    /// Cualquier otra condición no categorizada.
    case unknown
}
