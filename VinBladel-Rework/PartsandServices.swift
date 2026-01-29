//
//  PartsandServices.swift
//  VinBladel-Rework
//
//  Created by Aadi Shah on 12/15/25.
//

import SwiftUI

struct PartsandServices: View {
    var parts: [Part] = []
    var body: some View {
        NavigationStack{
            List{
                NavigationLink(destination: Existing()) {
                    Text("Go to summary")
                        .frame(width: 100, height: 50)
                        .foregroundStyle(.black)
                        .background(RoundedRectangle(cornerRadius: 10).foregroundStyle(.orange))
                        .padding()
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


#Preview {
    PartsandServices()
}
