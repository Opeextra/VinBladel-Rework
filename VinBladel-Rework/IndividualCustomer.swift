//
//  IndividualCustomer.swift
//  VinBladel-Rework
//
//  Created by Aadi Shah on 12/15/25.
//

import SwiftUI

struct IndividualCustomer: View {
    var body: some View {
        NavigationStack{
            NavigationLink(destination: Exsisting()) {
                Text("List")
                    .frame(width: 100, height: 50)
                    .foregroundStyle(.black)
                    .background(RoundedRectangle(cornerRadius: 10).foregroundStyle(.orange))
                    .padding()
            }
        }
    }
}

#Preview {
    IndividualCustomer()
}
