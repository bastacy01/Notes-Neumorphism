//
//  NoteEditView.swift
//  Notes
//
//  Created by Ben Stacy on 1/31/25.
//

import SwiftUI

struct NoteEditView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var notes: [Note]
    let notesKey: String
    let existingNote: Note?
    let isNewNote: Bool
    let availableColors: [Color]
    
    @State private var noteText: String
    @State private var selectedCategory: Note.Category
    @State private var selectedColorIndex: Int
    
    init(notes: Binding<[Note]>, notesKey: String, existingNote: Note?, isNewNote: Bool, availableColors: [Color]) {
        self._notes = notes
        self.notesKey = notesKey
        self.existingNote = existingNote
        self.isNewNote = isNewNote
        self.availableColors = availableColors
        self._noteText = State(initialValue: existingNote?.text ?? "")
        self._selectedCategory = State(initialValue: existingNote?.category ?? .personal)
        self._selectedColorIndex = State(initialValue: existingNote?.colorIndex ?? 0)
    }
    @FocusState private var isFocused: Bool
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                TextEditor(text: $noteText)
                    .focused($isFocused)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
                    .padding(.leading, -15)
                    .background(Color(.systemBackground))
                    .foregroundStyle(.black)
                    .cornerRadius(16)
                    .padding(.horizontal)
            }
            .navigationTitle(isNewNote ? "New Note" : "Edit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .font(.headline)
                    .foregroundStyle(.black)
                    .fontWeight(.medium)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveNote()
                    }
                    .font(.headline)
                    .foregroundStyle(.black)
                    .fontWeight(.medium)
                    .opacity(noteText.isEmpty ? 0.5 : 1.0)
                    .disabled(noteText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
            .onAppear {
                isFocused = true 
            }
        }
    }
    private func saveNote() {
        let trimmedText = noteText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if isNewNote {
            let note = Note(
                text: trimmedText,
                date: Date(),
                category: selectedCategory,
                colorIndex: selectedColorIndex
            )
            notes.insert(note, at: 0)
        } else if let existingNote = existingNote,
                  let index = notes.firstIndex(where: { $0.id == existingNote.id }) {
            notes[index] = Note(
                id: existingNote.id,
                text: trimmedText,
                date: Date(),
                category: selectedCategory,
                colorIndex: selectedColorIndex
            )
        }
        if let encoded = try? JSONEncoder().encode(notes) {
            UserDefaults.standard.set(encoded, forKey: notesKey)
        }
        dismiss()
    }
}


