//
//  AppState.swift
//  TaskFlow Onboarding
//
//  Created by Joseph DeWeese on 4/11/25.
//

import Foundation

class AppState: ObservableObject {
    @Published var isOnboardingComplete: Bool {
        didSet {
            UserDefaults.standard.set(isOnboardingComplete, forKey: "isOnboardingComplete")
        }
    }
    
    init() {
        self.isOnboardingComplete = UserDefaults.standard.bool(forKey: "isOnboardingComplete")
    }
}
