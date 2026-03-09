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
        "2 Wheel Alignment": ServicePart(name: "2 Wheel Alignment", id: "2 Wheel Alignment", price: 25),
        "4 Wheel Alignment": ServicePart(name: "4 Wheel Alignment", id: "4 Wheel Alignment", price: 50),
        "Alignment Check": ServicePart(name: "Alignment Check", id: "Alignment Check", price: 0),
        "Reset Stability Control Settings": ServicePart(name: "Reset Stability Control Settings", id: "Reset Stability Control Settings", price: 10),
        "Battery Charge": ServicePart(name: "Battery Charge", id: "Battery Charge", price: 0),
        "Battery Replacement": ServicePart(name: "Battery Replacement", id: "Battery Replacement", price: 10),
        "Battery Test": ServicePart(name: "Battery Test", id: "Battery Test", price: 0),
        "Brake Fluid Flush": ServicePart(name: "Brake Fluid Flush", id: "Brake Fluid Flush", price: 5),
        "Brake Fluid Test": ServicePart(name: "Brake Fluid Test", id: "Brake Fluid Test", price: 5),
        "Brake Inspection": ServicePart(name: "Brake Inspection", id: "Brake Inspection", price: 0),
        "Braking System Donation": ServicePart(name: "Braking System Flat Rate Donation", id: "Braking System Flat Rate Donation", price: 25),
        "Front Pads and Rotors": ServicePart(name: "Front Pads and Rotors", id: "Front Pads and Rotors", price: 25),
        "Wheel Speed Sensor Replacement": ServicePart(name: "Wheel Speed Sensor Replacement", id: "Wheel Speed Sensor Replacement", price: 0),
        "Alternator Test": ServicePart(name: "Alternator Test", id: "Alternator Test", price: 0),
        "Charging System Donation": ServicePart(name: "Charging System Flat Rate Donation", id: "Charging System Flat Rate Donation", price: 25),
        "1 Gal Coolant": ServicePart(name: "1 Gal Coolant", id: "1 Gal Coolant", price: 12.99),
        "Coolant Flush": ServicePart(name: "Coolant Flush", id: "Coolant Flush", price: 25),
        "Coolant Test": ServicePart(name: "Coolant Test", id: "Coolant Test", price: 5),
        "Cooling System Flat Rate Donation": ServicePart(name: "Cooling System Flat Rate Donation", id: "Cooling System Donation", price: 25),
        "Cooling System Pressure Test": ServicePart(name: "Cooling System Pressure Test", id: "Cooling System Pressure Test", price: 15),
        "ABS Light Diagnostic": ServicePart(name: "ABS Light Diagnostic", id: "ABS Light Diagnostic", price: 0),
        "Check Engine Light Diagnostic": ServicePart(name: "Check Engine Light Diagnostic", id: "Check Engine Light Diagnostic", price: 0),
        "SRS Light Diagnostic": ServicePart(name: "SRS Light Diagnostic", id: "SRS Light Diagnostic", price: 0),
        "Compression Test": ServicePart(name: "Compression Test", id: "Compression Test", price: 0),
        "Engine Air Filter": ServicePart(name: "Engine Air Filter", id: "Engine Air Filter", price: 0),
        "Engine Donation": ServicePart(name: "Engine Flat Rate Donation", id: "Engine Flat Rate Donation", price: 25),
        "Ignition Coil Replacement": ServicePart(name: "Ignition Coil Replacement", id: "Ignition Coil Replacement", price: 0),
        "Plug Wires": ServicePart(name: "Plug Wires", id: "Plug Wires", price: 0),
        "Spark Plugs": ServicePart(name: "Spark Plugs", id: "Spark Plugs", price: 0),
        "Differential Gear Oil": ServicePart(name: "Differential Gear Oil", id: "Differential Gear Oil", price: 0),
        "Fluids Donation": ServicePart(name: "Fluids Donation", id: "Fluids Donation", price: 25),
        "Manual Transmission Fluid": ServicePart(name: "Manual Transmission Fluid", id: "Manual Transmission Fluid", price: 0),
        "Cabin Air Filter": ServicePart(name: "Cabin Air Filter", id: "Cabin Air Filter", price: 0),
        "Manual Donation": ServicePart(name: "Manual Donation", id: "Manual Donation", price: 0),
        "1 Qt Specialty Oil": ServicePart(name: "1 Qt Specialty Oil", id: "1 Qt Specialty Oil", price: 4),
        "Drain Plug": ServicePart(name: "Drain Plug", id: "Drain Plug", price: 4),
        "NAPA High Mileage 10w_30": ServicePart(name: "NAPA High Mileage 10w_30", id: "NAPA High Mileage 10w_30", price: 3.08),
        "NAPA Synthetic 0w_20": ServicePart(name: "NAPA Synthetic 0w_20", id: "NAPA Synthetic 0w_20", price: 4.46),
        "NAPA Synthetic 5w_30": ServicePart(name: "NAPA Synthetic 5w_30", id: "NAPA Synthetic 5w_30", price: 4.46),
        "NAPA Synthetic 5w_20": ServicePart(name: "NAPA Synthetic 5w_20", id: "NAPA Synthetic 5w_20", price: 3.83),
        "NAPA Synthetic Blend 5w_20": ServicePart(name: "NAPA Synthetic Blend 5w_20", id: "NAPA Synthetic Blend 5w_20", price: 2.74),
        "Oil System Flush": ServicePart(name: "Oil System Flush", id: "Oil System Flush", price: 25),
        "Reset Service Reminder Lamp": ServicePart(name: "Reset Service Reminder Lamp", id: "Reset Service Reminder Lamp", price: 0),
        "Specialty Oil Filter": ServicePart(name: "Specialty Oil Filter", id: "Specialty Oil Filter", price: 0),
        "Valvoline Synthetic 0w_16": ServicePart(name: "Valvoline Synthetic 0w_16", id: "Valvoline Synthetic 0w_16", price: 4.6),
        "Valvoline Synthetic 0w_20": ServicePart(name: "Valvoline Synthetic 0w_20", id: "Valvoline Synthetic 0w_20", price: 4.46),
        "Valvoline Synthetic 5w_20": ServicePart(name: "Valvoline Synthetic 5w_20", id: "Valvoline Synthetic 5w_20", price: 4.46),
        "Valvoline Synthetic 5w_30": ServicePart(name: "Valvoline Synthetic 5w_30", id: "Valvoline Synthetic 5w_30", price: 4.46),
        "Valvoline Synthetic 5w_30 EURO": ServicePart(name: "Valvoline Synthetic 5w_30 EURO", id: "Valvoline Synthetic 5w_30 EURO", price: 6.38),
        "Starting System Donation": ServicePart(name: "Starting System Donation", id: "Starting System Donation", price: 25),
        "Starting System Test": ServicePart(name: "Starting System Test", id: "Starting System Test", price: 0),
        "Quick Strut Installation": ServicePart(name: "Quick Strut Installation", id: "Quick Strut Installation", price: 0),
        "Replace Springs": ServicePart(name: "Replace Springs", id: "Replace Springs", price: 0),
        "Replace Strut-Shock": ServicePart(name: "Replace Strut-Shock", id: "Replace Strut-Shock", price: 0),
//        "Replace Sway Bar  Endlinks": ServicePart(name: "Replace Strut-Shock", id: <#T##String#>, price: <#T##Double#>)
    ]
    @State var showAlert: Bool = false
    @State private var searchText: String = ""
    
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(parts.values
                    .filter {searchText.isEmpty || $0.name.localizedCaseInsensitiveContains(searchText)}
                    .sorted(by:{$0.name < $1.name}),
                        id: \.id
                ) { part in
                    // sorts alphabetically a...z
                    NavigationLink(destination: PartView(parts: $parts, part: part)) {
                        HStack(spacing: 12) {
                            Text(part.name)
                            Spacer()
                            Stepper(
                                value: Binding<Int>(
                                    get: {parts[part.id]?.count ?? part.count },
                                    set: {newValue in
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
                        Text("Add Custom Part")
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
        @State var priceIsEmpty: Bool = false
        @Binding var parts: [String: ServicePart]
        var body: some View {
            if addPart.isEmpty{
                Text("Enter a name!")
            }
            if priceIsEmpty{
             Text("Enter a price!")
            }
            TextField("Enter Name", text: $addPart)
            TextField("Enter Price", text: $price)
                .keyboardType(.decimalPad)
            Button("Add"){
                if let priceDouble: Double = Double(price){
                    if parts[addPart] == nil {
                        parts[addPart] = ServicePart(name: addPart, id: addPart, price: priceDouble)
                        priceIsEmpty = false
                        
                    }
                } else {
                    priceIsEmpty = true
                }
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

