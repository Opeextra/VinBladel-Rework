//
//  PartsandServices.swift
//  VinBladel-Rework
//
//  Created by Aadi Shah on 12/15/25.
//

import SwiftUI

struct ServicePart: Identifiable, Hashable {
    var name: String
    var id: String
    var price: Double
    var count: Int = 0
}

struct PartsandServices: View {
    @State var parts: [String: ServicePart] = [
        "Example": ServicePart(name: "Example", id: "Example", price: 100)
    ]
    @State var showAlert: Bool = false
    
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(parts.values.sorted(by: { $0.name < $1.name }), id: \.id) { part in
                    // sorts alphabetically a...z
                    NavigationLink(destination: PartView(parts: $parts, part: part)) {
                        HStack(spacing: 12) {
                            Text(part.name)
                            Spacer()
                            Stepper(
                                value: Binding<Int>(
                                    get: { parts[part.id]?.count ?? part.count },
                                    set: { newValue in
                                        var updated = parts[part.id] ?? part
                                        updated.count = newValue
                                        parts[part.id] = updated
                                    }
                                ),
                                in: 0...20
                            ) {
                                Text("Count: \(parts[part.id]?.count ?? part.count)")
                            }
                        }
                    }
                }
            }
            
            .navigationTitle("Parts & Services")
            HStack(spacing: 12) {
                NavigationLink(destination: NewPart(parts: $parts)) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(.orange)
                        Text("Add Part")
                            .font(.custom("Arial", size: 40))
                            .foregroundStyle(.black)
                    }
                    .frame(width: 320, height: 88)
                }
                .padding(.vertical, 8)
                
                NavigationLink(destination: InvoiceView()) {
                    Text("Go to summary")
                        .font(.custom("Arial", size: 40))
                        .frame(width: 320, height: 88)
                        .foregroundStyle(.black)
                        .background(RoundedRectangle(cornerRadius: 10).foregroundStyle(.orange))
                }
                .padding(.vertical, 8)
            }
        }
    }
    
    struct NewPart: View {
        @State var addPart: String = ""
        @State var price: String = ""
        @Binding var parts: [String: ServicePart]
        var body: some View {
            TextField("Search by name", text: $addPart)
            TextField("Enter Price", text: $price) //MARK: Change this when Firebase is set up
            Button("Add"){
                parts[addPart] = ServicePart(name: addPart, id: addPart, price: Double(price) ?? 0)
            }
        }
    }
    
    
    struct Existing: View {
        var body: some View {
            Text("Summary")
        }
    }
    
    struct PartView: View {
        @Binding var parts: [String: ServicePart]
        var part: ServicePart
        var body: some View {
            VStack(alignment: .leading, spacing: 12) {
                Text(part.name)
                    .font(.title2)
                Text("ID: \(part.id)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Text(String(format: "Price: $%.2f", part.price))
                Text("Count: \(parts[part.id]?.count ?? part.count)")
                Spacer()
            }
            .padding()
            .navigationTitle("Part Details")
        }
        func costInterpreter(price: Double, count: Int) -> Double{
            return price * Double(count)
        }
    }
}

