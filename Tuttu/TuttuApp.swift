//
//  TuttuApp.swift
//  Tuttu
//
//  Created by Marco Antonio Landauro Alba on 12/11/25.
//

import SwiftUI
import SwiftData

@main
struct TuttuApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
        .modelContainer(for: TodoObject.self)
    }
}
