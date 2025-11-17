//
//  RootView.swift
//  Tuttu
//
//  Created by Marco Antonio Landauro Alba on 16/11/25.
//

import SwiftUI
import SwiftData

struct RootView: View {
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        let container = TuttuCompositionRoot(context: modelContext)

        // Por ahora solo tenemos la lista principal de Tuttu
        container.makeTodoListView()
    }
}
