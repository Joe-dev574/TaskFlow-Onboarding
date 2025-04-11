//
//  IntroScreen.swift
//  TaskFlow Onboarding
//
//  Created by Joseph DeWeese on 4/11/25.
//

import SwiftUI
import UIKit // For haptics

struct IntroScreen: View {
    @Binding var currentPage: Int
    @State private var animationPhase: AnimationPhase = .initial
    @State private var showNextButton = false
    
    private let features: [(title: String, symbol: String, color: Color)] = [
        ("Create Tasks", "checkmark.circle", Category.today.color),
        ("Create Projects", "folder.badge.plus", Category.work.color),
        ("Organize with Categories", "square.grid.2x2", Category.family.color),
        ("Tags", "tag", Category.health.color),
        ("Notes", "note.text", Category.learn.color),
        ("Attach Files", "paperclip", Category.bills.color),
        ("Export Reports", "square.and.arrow.up", Category.events.color)
    ]
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.gray.opacity(0.02), .gray.opacity(0.1)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                // "Explore" at top with radiant black
                if animationPhase == .settle {
                    Text("Explore")
                        .font(.system(size: 32, weight: .bold, design: .serif))
                        .foregroundStyle(.black)
                        .shadow(color: .gray.opacity(0.6), radius: 5, x: 0, y: 2)
                        .overlay(
                            LinearGradient(
                                colors: [.black, .gray.opacity(0.7), .black],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                            .mask(Text("Explore")
                                .font(.system(size: 32, weight: .bold, design: .serif)))
                        )
                        .opacity(showNextButton ? 1 : 0)
                        .animation(.easeIn(duration: 0.2), value: showNextButton)
                        .accessibilityLabel("Explore Task Flow")
                } else {
                    Spacer().frame(height: 32) // Placeholder during animation
                }
                
                // Larger LogoView
                if animationPhase == .settle {
                    LogoView()
                        .frame(width: 250, height: 50) // Increased size
                        .accessibilityLabel("Task Flow logo")
                        .opacity(showNextButton ? 1 : 0)
                        .animation(.easeIn(duration: 0.3), value: showNextButton)
                }
                
                // Feature blocks
                ZStack {
                    ForEach(features.indices, id: \.self) { index in
                        FeatureView(
                            title: features[index].title,
                            symbol: features[index].symbol,
                            color: features[index].color,
                            phase: animationPhase,
                            index: index,
                            totalFeatures: features.count
                        )
                        .accessibilityElement(children: .combine)
                        .accessibilityLabel(features[index].title)
                    }
                }
                .frame(maxHeight: UIScreen.main.bounds.height * 0.7)
                .offset(y: animationPhase == .settle ? -175 : 0) // Raised 100pt more (200 total)
                
                Spacer()
                
                // Next button 80pt from bottom (50pt + 30pt drop)
                if showNextButton {
                    Button(action: {
                        withAnimation {
                            currentPage = 2
                        }
                    }) {
                        Text("Next")
                            .font(.system(size: 16, weight: .semibold, design: .serif))
                            .foregroundStyle(.white)
                            .frame(maxWidth: 325, minHeight: 50)
                            .padding(.horizontal, 24)
                            .background(Category.today.color)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .shadow(color: Category.today.color.opacity(0.3), radius: 4, x: 0, y: 2)
                    }
                    .padding(.bottom, 20)
                    .accessibilityLabel("Next")
                    .accessibilityHint("Tap to proceed to sign in")
                    .transition(.opacity)
                }
            }
            .hSpacing(.center)
            .padding(.bottom, 20) // Safe area padding
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 0.6).delay(0.3)) {
                animationPhase = .rotate
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                    animationPhase = .settle
                    let generator = UINotificationFeedbackGenerator()
                    generator.notificationOccurred(.success)
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
                withAnimation(.easeIn(duration: 0.3)) {
                    showNextButton = true
                }
            }
        }
    }
    
    enum AnimationPhase {
        case initial, rotate, settle
    }
}

struct FeatureView: View {
    let title: String
    let symbol: String
    let color: Color
    let phase: IntroScreen.AnimationPhase
    let index: Int
    let totalFeatures: Int
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: symbol)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .foregroundStyle(.white)
                .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 1)
            
            Text(title)
                .font(.system(.headline, design: .serif))
                .foregroundStyle(.white)
                .shadow(color: .black.opacity(0.3), radius: 1, x: 1, y: 1)
        }
        .padding()
        .frame(width: 180, height: 90)
        .background(color.opacity(0.6))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .offset(calculateOffset())
        .scaleEffect(phase == .initial ? 0.8 : 1.0)
        .zIndex(phase == .settle ? Double(totalFeatures - index) : 0)
        .shadow(radius: phase == .settle ? 5 : 0)
        .blur(radius: phase == .settle ? 0 : 2)
        .animation(.spring(response: 0.4, dampingFraction: 0.8).delay(Double(index) * 0.1), value: phase)
    }
    
    private func calculateOffset() -> CGSize {
        let screenHeight = UIScreen.main.bounds.height
        let baseSpacing = screenHeight / 8
        
        switch phase {
        case .initial:
            switch index {
            case 0: return CGSize(width: -200, height: -200)
            case 1: return CGSize(width: 200, height: -200)
            case 2: return CGSize(width: -150, height: -100)
            case 3: return CGSize(width: 150, height: -100)
            case 4: return CGSize(width: -150, height: 100)
            case 5: return CGSize(width: 150, height: 100)
            case 6: return CGSize(width: 0, height: 200)
            default: return .zero
            }
        case .rotate:
            return CGSize(width: 0, height: CGFloat(index - (totalFeatures - 1) / 2) * baseSpacing)
        case .settle:
            let row = index / 2
            let col = index % 2
            return CGSize(width: index == 6 ? 0 : (col == 0 ? -100 : 100), height: CGFloat(row) * baseSpacing)
        }
    }
}
