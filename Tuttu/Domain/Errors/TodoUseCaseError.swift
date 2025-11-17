//
//  TodoUseCaseError.swift
//  Tuttu
//
//  Created by Marco Antonio Landauro Alba on 16/11/25.
//

import Foundation

public enum TodoUseCaseError: Error, Equatable {
    /// El input del caso de uso no cumple las reglas de negocio.
    case validation(TodoValidationError)

    /// Algún problema al leer/escribir datos.
    case repository(TodoRepositoryError)
}
