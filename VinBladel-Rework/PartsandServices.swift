//
//  PartsandServices.swift
//  VinBladel-Rework
//
//  Created by Aadi Shah on 12/15/25.
//

import SwiftUI

struct PartsandServices: View {
    @State var parts: [String: Part] = [
        "Example": Part(name: "Example Part", id: "Example", price: 0)
    ]
    @State var fallback: Part = Part(name: "No parts", id: "fallback", price: 0)

    var body: some View {
        NavigationStack {
            List {
                if let part = parts["Example"] {
                    NavigationLink(destination: PartView(parts: $parts, part: part)) {
                        HStack(spacing: 12) {
                            Text(part.name)
                            Spacer()
                            Stepper(
                                value: Binding<Int>(
                                    get: { parts["Example"]?.count ?? 0 },
                                    set: { newValue in
                                        var updated = parts["Example"] ?? fallback
                                        updated.count = newValue
                                        parts["Example"] = updated
                                    }
                                ),
                                in: 0...20
                            ) {
                                Text("Count: \(parts["Example"]?.count ?? 0)")
                            }
                            
                        }
                    }
                } else {
                    Text("No Example part available")
                }
            }
            .navigationTitle("Parts & Services")
        }
        NavigationLink(destination: Existing()) {
            Text("Go to summary")
                .frame(width: 160, height: 44)
                .foregroundStyle(.black)
                .background(RoundedRectangle(cornerRadius: 10).foregroundStyle(.orange))
                .padding(.vertical, 8)
        }
    }
}

struct Part: Identifiable, Hashable {
    var name: String
    var id: String
    var price: Double
    var count: Int = 0
}

struct PartView: View {
    @Binding var parts: [String: Part]
    var part: Part

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(part.name)
                .font(.title2)
            Text("ID: \(part.id)")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            Text(String(format: "Price: $%.2f", part.price))
            Text("Count: \(parts[part.name]?.count ?? part.count)")
            Spacer()
        }
        .padding()
        .navigationTitle("Part Details")
    }
    func costInterpreter(price: Double, count: Int) -> Double{
        return price * Double(count)
    }
}

#Preview {
    PartsandServices()
}
