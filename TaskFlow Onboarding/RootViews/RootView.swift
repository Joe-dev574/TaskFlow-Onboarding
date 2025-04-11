//
//  RootView.swift
//  TaskFlow Onboarding
//
//  Created by Joseph DeWeese on 4/11/25.
//

import SwiftUI
import SwiftData

struct RootView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var users: [User]
    
    var body: some View {
        Group {
            if let user = users.first, user.isOnboardingComplete {
                ContentView()
            } else {
                OnboardingView()
                    .onAppear {
                        if users.isEmpty {
                            let newUser = User()
                            modelContext.insert(newUser)
                            try? modelContext.save()
                        }
                    }
            }
        }
    }
}
