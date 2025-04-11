//
//  LogoView.swift
//  TaskFlow
//
//  Created by Joseph DeWeese on 3/25/25.
//

import SwiftUI




struct LogoView: View {
    // MARK: - Animation States
    
    /// The rotation angle of the gear in degrees
    @State private var rotationAngle: Double = 0.0
    
    /// The opacity level of the gear
    @State private var gearOpacity: Double = Constants.initialGearOpacity
    
    /// The scale factor for the gear's pulse animation
    @State private var gearScale: Double = 1.0
    
    /// The vertical offset for text bounce animation
    @State private var textOffset: CGFloat = 0.0
    
    /// The intensity of the gear's glow effect
    @State private var glowIntensity: Double = 0.3
    
    // MARK: - Environment
    
    /// Detects the current color scheme (light or dark)
    @Environment(\.colorScheme) var colorScheme
    
    /// Respects the user's reduced motion preference
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    
    // MARK: - Body
    
    var body: some View {
        HStack(spacing: Constants.spacing) {
            // Gear icon with animation and glow effects
            Image(systemName: "gearshape.2.fill")
                .resizable()
                .frame(width: Constants.gearSize, height: Constants.gearSize)
                .foregroundStyle(
                    LinearGradient(
                        colors: gearGradientColors,
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .opacity(gearOpacity)
                .rotationEffect(.degrees(rotationAngle))
                .scaleEffect(gearScale)
                .shadow(color: glowColor, radius: 5, x: 0, y: 2)
                .overlay(
                    Circle()
                        .stroke(glowColor, lineWidth: 1)
                        .scaleEffect(gearScale * 1.2)
                        .opacity(glowIntensity)
                )
                .onAppear(perform: startAnimation)
                .accessibilityLabel("Animated gear icon")
                .accessibilityHint("Part of the Task Flow logo")
                .accessibilityHidden(reduceMotion) // Hides animation details if motion reduced
            
            // Text group with dynamic styling
            HStack(spacing: Constants.textSpacing) {
                Text("Task")
                    .font(.custom("Avenir-Heavy", size: 18))
                    .foregroundStyle(textGradient)
                    .offset(y: textOffset)
                
                Text("Flow")
                    .font(.custom("Avenir-Black", size: 18))
                    .foregroundStyle(textGradient)
                    .offset(y: -textOffset)
                
                Text("1.0")
                    .font(.system(.body, design: .serif))
                    .foregroundStyle(versionColor)
                    .rotationEffect(.degrees(15))
                    .offset(x: 2)
            }
            .shadow(color: shadowColor, radius: 2)
            .accessibilityElement(children: .combine)
            .accessibilityLabel("Task Flow version 1.0")
            .accessibilityHint("App logo and version")
        }
        .padding(.vertical, 8)
        .frame(maxHeight: Constants.maxHeight)
        .background(backgroundOverlay)
    }
    
    // MARK: - Adaptive Styling
    
    /// Gradient colors for the gear, adjusted for color scheme
    private var gearGradientColors: [Color] {
        colorScheme == .dark
            ? [.cyan.opacity(0.9), .purple.opacity(0.7)]
            : [.blue.opacity(0.9), .cyan.opacity(0.7)]
    }
    
    /// Gradient for text, optimized for readability
    private var textGradient: LinearGradient {
        LinearGradient(
            colors: colorScheme == .dark
                ? [.white.opacity(0.9), .gray.opacity(0.7)]
                : [.black.opacity(0.9), .gray.opacity(0.8)],
            startPoint: .top,
            endPoint: .bottom
        )
    }
    
    /// Color for the version number, mode-specific
    private var versionColor: Color {
        colorScheme == .dark ? .yellow.opacity(0.9) : .orange.opacity(0.9)
    }
    
    /// Glow color that adapts to the color scheme
    private var glowColor: Color {
        colorScheme == .dark ? .cyan.opacity(glowIntensity) : .blue.opacity(glowIntensity)
    }
    
    /// Shadow color with mode-appropriate opacity
    private var shadowColor: Color {
        colorScheme == .dark ? .gray.opacity(0.4) : .gray.opacity(0.2)
    }
    
    /// Background overlay for contrast enhancement
    private var backgroundOverlay: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(colorScheme == .dark ? Color.black.opacity(0.2) : Color.white.opacity(0.2))
            .shadow(color: shadowColor, radius: 3)
    }
    
    // MARK: - Constants
    
    /// Static values used throughout the view
    private enum Constants {
        static let gearSize: CGFloat = 32
        static let initialGearOpacity: Double = 1.0
        static let finalGearOpacity: Double = 0.85
        static let spacing: CGFloat = 6
        static let textSpacing: CGFloat = 3
        static let fastDuration: Double = 0.6
        static let slowDuration: Double = 0.4
        static let fadeDuration: Double = 0.25
        static let pulseDuration: Double = 1.0
        static let fastRotations: Double = 1.25
        static let maxHeight: CGFloat = 40
    }
    
    // MARK: - Animation
    
    /// Orchestrates the logo's animation sequence, respecting reduced motion settings
    private func startAnimation() {
        guard !reduceMotion else {
            gearOpacity = Constants.finalGearOpacity // Static state for no motion
            return
        }
        
        // 1. Initial fast spin and scale up with glow
        withAnimation(.easeInOut(duration: Constants.fastDuration)) {
            rotationAngle = 360 * Constants.fastRotations
            gearScale = 1.15
            glowIntensity = 0.5
        }
        
        // 2. Bounce and settle with spring effect
        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.fastDuration) {
            withAnimation(.spring(response: Constants.slowDuration, dampingFraction: 0.7)) {
                rotationAngle = 360 * Constants.fastRotations + 30
                gearScale = 0.95
                textOffset = 3
                glowIntensity = 0.3
            }
        }
        
        // 3. Final settle with fade
        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.fastDuration + Constants.slowDuration) {
            withAnimation(.easeInOut(duration: Constants.fadeDuration)) {
                gearOpacity = Constants.finalGearOpacity
                gearScale = 1.0
                textOffset = 0
            }
        }
        
        // 4. Continuous subtle pulse with glow
        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.fastDuration + Constants.slowDuration + Constants.fadeDuration) {
            withAnimation(.easeInOut(duration: Constants.pulseDuration).repeatForever(autoreverses: true)) {
                gearScale = 1.05
                glowIntensity = 0.4
            }
        }
    }
}

// MARK: - Preview

#Preview {
    VStack {
        LogoView()
            .preferredColorScheme(.light)
        
        LogoView()
            .preferredColorScheme(.dark)
    }
    .padding()
    .background(Color(.systemBackground))
}
