//
//  ContentView.swift
//  TaskFlow Onboarding
//
//  Created by Joseph DeWeese on 4/11/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [.gray.opacity(0.02), .gray.opacity(0.1)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    Text("TaskFlow2025")
                        .font(.system(size: 28, weight: .bold, design: .serif))
                        .foregroundStyle(.primary)
                    
                    if items.isEmpty {
                        Text("No tasks yet.")
                            .font(.system(size: 18, design: .serif))
                            .foregroundStyle(.secondary)
                    } else {
                        List(items) { item in
                            HStack {
                                Image(systemName: Category(rawValue: item.category)?.symbolImage ?? "questionmark")
                                    .foregroundStyle(Category(rawValue: item.category)?.color ?? .gray)
                                VStack(alignment: .leading) {
                                    Text(item.title)
                                        .font(.system(.body, design: .serif))
                                    Text(item.remarks)
                                        .font(.system(.caption, design: .serif))
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }
                    }
                    
                    Spacer()
                    
                    // Debug reset button
                    Button("Reset Onboarding") {
                        if let user = try? modelContext.fetch(FetchDescriptor<User>()).first {
                            modelContext.delete(user)
                            try? modelContext.save()
                        }
                    }
                    .font(.system(.callout, design: .serif))
                    .foregroundStyle(.white)
                    .padding()
                    .background(Color.red)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.bottom, 20)
                }
               
            }
            .navigationTitle("Tasks")
        }
    }
}
