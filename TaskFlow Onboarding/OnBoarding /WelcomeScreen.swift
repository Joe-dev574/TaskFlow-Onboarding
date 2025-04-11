//
//  WelcomeScreen.swift
//  TaskFlow Onboarding
//
//  Created by Joseph DeWeese on 4/11/25.
//

import SwiftUI

struct WelcomeScreen: View {
    @Binding var currentPage: Int
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.gray.opacity(0.02), .gray.opacity(0.1)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 25) {
                Image(systemName: "list.bullet.rectangle.portrait.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundStyle(Category.today.color)
                    .opacity(isAnimating ? 1 : 0)
                    .scaleEffect(isAnimating ? 1.0 : 0.9)
                    .animation(.easeInOut(duration: 0.6).delay(0.2), value: isAnimating)
                    .accessibilityLabel("TaskFlow Logo")
                
                Text("Welcome to TaskFlow2025")
                    .font(.system(size: 28, weight: .bold, design: .serif))
                    .foregroundStyle(.primary)
                    .offset(y: isAnimating ? 0 : 30)
                    .opacity(isAnimating ? 1 : 0)
                    .animation(.easeOut(duration: 0.6).delay(0.4), value: isAnimating)
                    .accessibilityLabel("Welcome to TaskFlow2025")
                
                Text("Streamline your tasks, projects, and notes effortlessly.")
                    .font(.system(size: 18, weight: .regular, design: .serif))
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .opacity(isAnimating ? 1 : 0)
                    .animation(.easeIn(duration: 0.6).delay(0.6), value: isAnimating)
                    .accessibilityLabel("Streamline your tasks, projects, and notes effortlessly")
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        currentPage = 1
                    }
                }) {
                    Text("Get Started")
                        .font(.system(size: 16, weight: .semibold, design: .serif))
                        .foregroundStyle(.white)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 24)
                        .background(Category.today.color)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Category.today.color.opacity(0.5), lineWidth: 2)
                                .opacity(isAnimating ? 1 : 0)
                                .animation(.easeInOut(duration: 0.8).delay(0.8), value: isAnimating)
                        )
                }
                .accessibilityLabel("Get Started")
                .accessibilityHint("Tap to begin exploring TaskFlow2025")
                
                Button(action: {
                    withAnimation {
                        currentPage = 2 // Changed from 3 to 2
                    }
                }) {
                    Text("Skip")
                        .font(.system(size: 14, weight: .medium, design: .serif))
                        .foregroundStyle(.gray)
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeIn(duration: 0.6).delay(1.0), value: isAnimating)
                }
                .accessibilityLabel("Skip Onboarding")
                .accessibilityHint("Tap to skip to sign in")
            }
            .padding(.vertical, 40)
            .hSpacing(.center)
        }
        .onAppear {
            isAnimating = true
        }
    }
}
