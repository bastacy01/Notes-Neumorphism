//
//  Note.swift
//  Notes
//
//  Created by Ben Stacy on 1/31/25.
//

import Foundation

struct Note: Identifiable, Codable {
    let id: UUID
    var text: String
    var date: Date
    var category: Category
    var colorIndex: Int
    
    init(id: UUID = UUID(), text: String, date: Date, category: Category = .personal, colorIndex: Int = 0) {
        self.id = id
        self.text = text
        self.date = date
        self.category = category
        self.colorIndex = colorIndex
    }
    
    enum Category: String, Codable, CaseIterable {
        case personal = "Personal"
        case work = "Work"
        case ideas = "Ideas"
        case tasks = "Tasks"
        
        var icon: String {
            switch self {
            case .personal: return "person.circle.fill"
            case .work: return "briefcase.fill"
            case .ideas: return "lightbulb.fill"
            case .tasks: return "checklist"
            }
        }
    }
}
