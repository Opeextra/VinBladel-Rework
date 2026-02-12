//
//  Exsisting.swift
//  VinBladel-Rework
//
//  Created by Aadi Shah on 12/15/25.
//

import SwiftUI

struct customer: Identifiable {
    let id: String
    let name: String
}

struct CustomerView: View {
    @Binding var customers: [String: customer]
    @State var customerInView: customer? = nil
    let customer: customer
    var body: some View {
        Text("\(customer.name)")
    }
}

struct Existing: View {
    @State var customers: [String: customer] = ["Test": customer(id: "Test", name: "Test")]
    var body: some View {
        NavigationStack{
            List{
                ForEach(Array(customers.values), id: \.id) { customer in
                    NavigationLink("\(customer.name)", destination: CustomerView(customers: $customers, customer: customer))
                }
            }
        }
    }
}

#Preview {
    Existing()
}
