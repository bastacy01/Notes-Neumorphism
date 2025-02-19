//
//  ListView.swift
//  Notes
//
//  Created by Ben Stacy on 1/31/25.
//

import SwiftUI

struct ListView: View {
    @State private var notes: [Note] = []
    @State private var showingNoteSheet = false
    @State private var searchText = ""
    @State private var selectedNote: Note?
    @State private var isNewNote = true
    @State private var selectedCategory: Note.Category?
    
    private let notesKey = "savedNotes"
    private let noteColors: [Color] = [.blue, .purple, .pink, .orange, .teal, .green, .red, .yellow]
    
    var filteredNotes: [Note] {
        var filtered = notes
        if let category = selectedCategory {
            filtered = filtered.filter { $0.category == category }
        }
        if !searchText.isEmpty {
            filtered = filtered.filter {
                $0.text.localizedCaseInsensitiveContains(searchText)
            }
        }
        return filtered.sorted { $0.date > $1.date }
    }
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ZStack {
                    Color(.systemGroupedBackground)
                        .ignoresSafeArea()
                    
                    if filteredNotes.isEmpty {
                        VStack(spacing: 12) {
                            Image(systemName: "note.text")
                                .font(.system(size: 60))
                                .foregroundStyle(.gray)
                            Text(searchText.isEmpty ? "No notes" : "No matches found")
                                .font(.title3)
                                .fontWeight(.medium)
                                .foregroundStyle(.gray)
                        }
                    } else {
                        ScrollView {
                            LazyVStack(spacing: 20) {
                                ForEach(filteredNotes) { note in
                                    NoteCard(note: note, color: noteColors[note.colorIndex]) {
                                        deleteNote(note)
                                    }
                                    .onTapGesture {
                                        selectedNote = note
                                        isNewNote = false
                                        showingNoteSheet = true
                                    }
                                }
                            }
                            .padding(.top, 5)
                        }
                        .padding(.top, 5)
                    }
                }
            }
//            .navigationTitle("Notes")
//            .searchable(text: $searchText, prompt: "Search")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        selectedNote = nil
                        isNewNote = true
                        showingNoteSheet = true
                    } label: {
                        Image(systemName: "plus")
                            .font(.system(size: 22))
                            .foregroundStyle(.black.opacity(0.6))
                            .frame(width: 15, height: 15)
                            .cornerRadius(15)
                            .neumorphic()
                    }
                    .padding(.top, 10)
                }
                ToolbarItem(placement: .principal) {
                    Text("Notes")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 5)
                        .offset(x: -138, y: 45)
                }
            }
            .sheet(isPresented: $showingNoteSheet) {
                NoteEditView(
                    notes: $notes,
                    notesKey: notesKey,
                    existingNote: selectedNote,
                    isNewNote: isNewNote,
                    availableColors: noteColors
                )
            }
         }
    }
    private func deleteNote(_ note: Note) {
        withAnimation {
            if let index = notes.firstIndex(where: { $0.id == note.id }) {
                notes.remove(at: index)
                saveNotes()
            }
        }
    }
    private func saveNotes() {
        if let encoded = try? JSONEncoder().encode(notes) {
            UserDefaults.standard.set(encoded, forKey: notesKey)
        }
        
        notes.sort { $0.date > $1.date }
    }
    private func loadNotes() {
        if let savedNotes = UserDefaults.standard.data(forKey: notesKey),
           let decodedNotes = try? JSONDecoder().decode([Note].self, from: savedNotes) {
            notes = decodedNotes
        }
    }
}

