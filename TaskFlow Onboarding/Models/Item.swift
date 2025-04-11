//
//  Item.swift
//  TaskFlow Onboarding
//
//  Created by Joseph DeWeese on 4/11/25.
//

import SwiftUI
import SwiftData

@Model
final class Item {
    var title: String
    var remarks: String
    var dateAdded: Date
    var dateStarted: Date
    var dateDue: Date
    var dateCompleted: Date
    var category: String
    var status: Item.Status.RawValue
    var tintColor: String
    
    init(
        title: String = "",
        remarks: String = "",
        dateAdded: Date = .now,
        dateDue: Date = .now,
        dateStarted: Date = .now,
        dateCompleted: Date = .now,
        status: Status = .Active,
        category: Category = .today,
        tintColor: TintColor
    ) {
        self.title = title
        self.remarks = remarks
        self.dateAdded = dateAdded
        self.dateDue = dateDue
        self.dateStarted = dateStarted
        self.dateCompleted = dateCompleted
        self.category = category.rawValue
        self.status = status.rawValue
        self.tintColor = tintColor.color
    }
    
    enum Status: Int, Codable, CaseIterable {
        case Plan, Upcoming, Active, Hold
        var descr: LocalizedStringResource {
            switch self {
            case .Plan: "Plan"
            case .Upcoming: "Upcoming"
            case .Active: "Active"
            case .Hold: "Hold"
            }
        }
    }
}
