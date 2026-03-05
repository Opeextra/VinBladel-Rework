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
    @State var parts: [String: ServicePart] = ["2 Wheel Alignment": ServicePart(name: "2 Wheel Alignment", id: "2 Wheel Alignment", price: 25), "4 Wheel Alignment": ServicePart(name: "4 Wheel Alignment", id: "4 Wheel Alignment", price: 50), "Alignment Check": ServicePart(name: "Alignment Check", id: "Alignment Check", price: 0), "Reset Stability Control Settings": ServicePart(name: "Reset Stability Control Settings", id: "Reset Stability Control", price: 10), "Battery Charge": ServicePart(name: "Battery Charge", id: "Battery Charge", price: 0), "Battery Replacement": ServicePart(name: "Battery Replacement", id: "Battery Replacement", price: 10), "Battery Test": ServicePart(name: "Battery Test", id: "Battery Test", price: 0), "Brake Fluid Flush": ServicePart(name: "Brake Fluid Flush", id: "Brake Fluid Flush", price: 5), "Brake Fluid Test": ServicePart(name: "Brake Fluid Test", id: "Brake Fluid Test", price: 5), "Brake Inspection": ServicePart(name: "Brake Inspection", id: "Brake Inspection", price: 0), "Braking System Flat Rate Donation": ServicePart(name: "Braking System Flat Rate Donation", id: "Braking System Flat Rate Donation", price: 25), "Front Pads and Rotors": ServicePart(name: "Front Pads and Rotors", id: "Front Pads and Rotors", price: 25), "Wheel Speed Sensor Replacement": ServicePart(name: "Wheel Speed Sensor Replacement", id: "Wheel Speed Sensor Replacement", price: 0),"Alternator Test": ServicePart(name: "Alternator Test", id: "Alternator Test", price: 0),"Charging System Flat Rate Donation": ServicePart(name: "Charging System Flat Rate Donation", id: "Charging System Flat Rate Donation", price: 25), "1 Gal Coolant": ServicePart(name: "1 Gal Coolant", id: "1 Gal Coolant", price: 12.99), "Coolant Flush": ServicePart(name: "Coolant Flush", id: "Coolant Flush", price: 25)]
    @State var showAlert: Bool = false
    @State private var searchText: String = ""
    
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(
                    parts.values
                        .filter { searchText.isEmpty || $0.name.localizedCaseInsensitiveContains(searchText) }
                        .sorted(by: { $0.name < $1.name }),
                    id: \.id
                ) { part in
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
            .searchable(text: $searchText, prompt: "Search Parts")
            
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
            TextField("Enter Price", text: $price).keyboardType(.decimalPad)
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

