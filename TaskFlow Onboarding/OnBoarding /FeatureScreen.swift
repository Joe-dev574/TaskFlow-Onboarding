//
//  FeatureScreen.swift
//  TaskFlow Onboarding
//
//  Created by Joseph DeWeese on 4/11/25.
//

import SwiftUI

struct FeatureScreen: View {
    let title: String
    let description: String
    let symbolName: String
    let color: Color
    @Binding var currentPage: Int
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: symbolName)
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .foregroundStyle(color)
                .accessibilityLabel("\(title) Icon")
                .accessibilityHint(Category.allCases.first { $0.symbolImage == symbolName }?.accessibilityHint ?? "Feature icon")
            
            Text(title)
                .font(.system(size: 24, weight: .bold, design: .serif))
                .foregroundStyle(UIColor(color).accessibleFontColor)
                .accessibilityLabel(title)
            
            Text(description)
                .font(.system(size: 18, design: .serif))
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .accessibilityLabel(description)
            
            Spacer()
            
            Button(action: {
                withAnimation {
                    currentPage += 1
                }
            }) {
                Text("Next")
                    .font(.system(.callout, design: .serif))
                    .foregroundStyle(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(color)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal)
            }
            .accessibilityLabel("Next")
            .accessibilityHint("Tap to view the next feature")
        }
        .padding(.vertical, 40)
        .hSpacing(.center)
    }
}
