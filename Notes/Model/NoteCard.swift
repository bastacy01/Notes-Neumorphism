//
//  NoteCard.swift
//  Notes
//
//  Created by Ben Stacy on 1/31/25.
//

import SwiftUI

struct NoteCard: View {
    let note: Note
    let color: Color
    let onDelete: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(note.text)
                .font(.body)
                .fontWeight(.medium)
                .lineLimit(1)
                .multilineTextAlignment(.leading)
                .shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 3)
            
            HStack {
                Text(note.date.formatted(date: .numeric, time: .shortened))
//                Text(note.date, format: Date.FormatStyle().year().month(.defaultDigits).day(.defaultDigits).hour().minute())
                    .font(.caption2)
                    .fontWeight(.medium)
                    .foregroundStyle(.secondary)
                    .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 3)
                
                Spacer()
                
                Button(action: onDelete) {
                    Image(systemName: "trash")
                        .foregroundStyle(.black)
                        .shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 3)
                        .contentShape(Rectangle())
                }
            }
        }
        .frame(width: 330, height: 50)
        .neumorphic()
    }
}
