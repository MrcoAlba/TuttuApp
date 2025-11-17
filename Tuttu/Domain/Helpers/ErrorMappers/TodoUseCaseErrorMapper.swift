//
//  TodoUseCaseErrorMapper.swift
//  Tuttu
//
//  Created by Marco Antonio Landauro Alba on 16/11/25.
//

import Foundation

enum TodoUseCaseErrorMapper {
    static func mapRepositoryError(_ error: Error) -> TodoUseCaseError {
        if let repoError = error as? TodoRepositoryError {
            return .repository(repoError)
        } else {
            return .repository(.unknown)
        }
    }
}
