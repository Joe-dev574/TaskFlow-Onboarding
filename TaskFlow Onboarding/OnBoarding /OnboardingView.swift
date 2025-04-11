//
//  OnBoardingView.swift
//  TaskFlow Onboarding
//
//  Created by Joseph DeWeese on 4/11/25.
//

import SwiftUI
import SwiftData

struct OnboardingView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var currentPage = 0
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.gray.opacity(0.02), .gray.opacity(0.1)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            switch currentPage {
            case 0:
                WelcomeScreen(currentPage: $currentPage)
            case 1:
                IntroScreen(currentPage: $currentPage)
            case 2:
                SignInScreen()
            default:
                EmptyView()
            }
        }
    }
}
