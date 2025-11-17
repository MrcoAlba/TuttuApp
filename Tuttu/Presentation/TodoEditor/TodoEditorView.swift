//
//  TodoEditorView.swift
//  Tuttu
//
//  Created by Marco Antonio Landauro Alba on 16/11/25.
//

import SwiftUI

struct TodoEditorView: View {

    var todo: Todo?
    let onSave: (String, String?) -> Void

    @Environment(\.dismiss) private var dismiss

    @State private var title: String = ""
    @State private var note: String = ""

    var body: some View {
        NavigationStack {
            Form {
                TextField("Título", text: $title)
                TextField("Nota (opcional)", text: $note)
            }
            .navigationTitle(todo == nil ? "Nuevo ToDo" : "Editar ToDo")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Guardar") {
                        onSave(title, note.isEmpty ? nil : note)
                        dismiss()
                    }
                    .disabled(title.trimmingCharacters(in: .whitespaces).isEmpty)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") { dismiss() }
                }
            }
        }
        .onAppear {
            if let todo {
                title = todo.title
                note = todo.note ?? ""
            }
        }
    }
}
