//
//  User.swift
//  TaskFlow Onboarding
//
//  Created by Joseph DeWeese on 4/11/25.
//

import SwiftData

@Model
final class User {
    var appleUserId: String?
    var isOnboardingComplete: Bool
    
    init(appleUserId: String? = nil, isOnboardingComplete: Bool = false) {
        self.appleUserId = appleUserId
        self.isOnboardingComplete = isOnboardingComplete
    }
}
