//
//  TodoListScreenState.swift
//  Tuttu
//
//  Created by Marco Antonio Landauro Alba on 16/11/25.
//

import Observation
import Foundation

@Observable
@MainActor
final class TodoListScreenState {
    var items: [Todo] = []
    var isLoading = false
    var errorMessage: String?
}
