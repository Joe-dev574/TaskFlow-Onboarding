//
//  SignInScreen.swift
//  TaskFlow Onboarding
//
//  Created by Joseph DeWeese on 4/11/25.
//

import SwiftUI
import AuthenticationServices
import SwiftData

struct SignInScreen: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.colorScheme) private var colorScheme
    @Query private var users: [User]
    @State private var showErrorAlert = false
    @State private var errorMessage = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Sign In to TaskFlow2025")
                .font(.system(size: 24, weight: .bold, design: .serif))
                .foregroundStyle(UIColor(Category.today.color).accessibleFontColor)
                .accessibilityLabel("Sign In to TaskFlow2025")
            
            Text("Use Sign in with Apple to get started.")
                .font(.system(size: 18, design: .serif))
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .accessibilityLabel("Use Sign in with Apple to get started")
            
            Spacer()
            
            SignInWithAppleButton(
                .signIn,
                onRequest: { request in
                    request.requestedScopes = [.fullName, .email]
                },
                onCompletion: { result in
                    switch result {
                    case .success(let authResults):
                        if let appleIDCredential = authResults.credential as? ASAuthorizationAppleIDCredential {
                            let userID = appleIDCredential.user
                            let fullName = appleIDCredential.fullName?.formatted() ?? "Not provided"
                            let email = appleIDCredential.email ?? "Not provided"
                            
                            print("Sign in with Apple Success:")
                            print("User ID: \(userID)")
                            print("Full Name: \(fullName)")
                            print("Email: \(email)")
                            
                            if let user = users.first {
                                user.appleUserId = userID
                                user.isOnboardingComplete = true
                            } else {
                                let newUser = User(appleUserId: userID, isOnboardingComplete: true)
                                modelContext.insert(newUser)
                            }
                            try? modelContext.save()
                        }
                    case .failure(let error):
                        errorMessage = "Sign in failed: \(error.localizedDescription)"
                        showErrorAlert = true
                        print("Sign in Error: \(error.localizedDescription)")
                    }
                }
            )
            .frame(height: 50)
            .frame(maxWidth: 375) // Cap width to avoid conflict
            .padding(.horizontal)
            .signInWithAppleButtonStyle(colorScheme == .dark ? .white : .black)
            .accessibilityLabel("Sign in with Apple")
            .accessibilityHint("Tap to sign in using your Apple ID")
        }
        .padding(.vertical, 40)
        .hSpacing(.center)
        .alert("Error", isPresented: $showErrorAlert) {
            Button("OK") { showErrorAlert = false }
        } message: {
            Text(errorMessage)
                .accessibilityLabel("Error: \(errorMessage)")
        }
    }
}
