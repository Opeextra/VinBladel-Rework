//
//  PartsandServices.swift
//  VinBladel-Rework
//
//  Created by Aadi Shah on 12/15/25.
//

import SwiftUI

struct PartsandServices: View {
    @State var parts: [String: Part] = ["Example": Part(name: "No parts", id: "0", price: 0)]
    @State var fallback: Part = Part(name: "No parts", id: "0", price: 0)
    var body: some View {
        NavigationStack{
            List{
                NavigationLink(destination: Existing()) {
                    Text("Go to summary")
                        .frame(width: 100, height: 50)
                        .foregroundStyle(.black)
                        .background(RoundedRectangle(cornerRadius: 10).foregroundStyle(.orange))
                        .padding()
                    NavigationLink(destination: PartView(parts: $parts, part: parts["Example"] ?? fallback)){
                        HStack{
                            Text("Example")
                        }
                    }
                }
            }
        }
    }
}

struct Part: Identifiable {
    var name: String
    var id: String
    var price: Double
}
struct PartView: View {
    @Binding var parts: [String: Part]
    @State var part: Part
    var body: some View {
        
    }
}

#Preview {
    PartsandServices()
}
