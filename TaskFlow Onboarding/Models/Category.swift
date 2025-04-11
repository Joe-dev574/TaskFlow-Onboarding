//
//  Category.swift
//  TaskFlow Onboarding
//
//  Created by Joseph DeWeese on 4/11/25.
//

import SwiftUI

enum Category: String, CaseIterable {
    case today = "Today"
    case work = "Work"
    case family = "Family"
    case health = "Health"
    case learn = "Learn"
    case bills = "Money"
    case events = "Events"
    
    var color: Color {
        switch self {
        case .today: return .color1
        case .work: return .color2
        case .family: return .color3
        case .health: return .color4
        case .learn: return .color6
        case .bills: return .color7
        case .events: return .primary
        }
    }
    
    var symbolImage: String {
        switch self {
        case .today: return "alarm"
        case .work: return "briefcase"
        case .family: return "figure.2.and.child.holdinghands"
        case .health: return "heart"
        case .learn: return "book"
        case .bills: return "banknote"
        case .events: return "repeat"
        }
    }
    
    var accessibilityLabel: String {
        switch self {
        case .today: return "Today"
        case .work: return "Work"
        case .family: return "Family"
        case .health: return "Health"
        case .learn: return "Learn"
        case .bills: return "Money"
        case .events: return "Events"
        }
    }
    
    var accessibilityHint: String {
        switch self {
        case .today: return "Category for tasks due today"
        case .work: return "Category for work-related tasks"
        case .family: return "Category for family-related tasks"
        case .health: return "Category for health and wellness tasks"
        case .learn: return "Category for learning and education tasks"
        case .bills: return "Category for financial obligations"
        case .events: return "Category for scheduled or recurring events"
        }
    }
}
