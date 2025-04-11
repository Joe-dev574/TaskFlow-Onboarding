//
//  TaskFlow_OnboardingApp.swift
//  TaskFlow Onboarding
//
//  Created by Joseph DeWeese on 4/11/25.
//

import SwiftUI
import SwiftData

@main
struct TaskFlow2025OnboardingApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
                .modelContainer(for: [User.self, Item.self])
        }
    }
}
