//
//  StartPage.swift
//  VinBladel-Rework
//
//  Created by Aadi Shah on 12/15/25.
//

import SwiftUI

struct StartPage: View {
    var body: some View {
        NavigationStack{
            HStack {
                NavigationLink(destination: Exsisting()) {
                    Text("Exsisting")
                }
                .frame(width: 100, height: 50)
                .foregroundStyle(.black)
                .background(RoundedRectangle(cornerRadius: 10).foregroundStyle(.orange))
                .padding()
                NavigationLink(destination: InProgress()) {
                    Text("In Progress")
                }
                .frame(width: 100, height: 50)
                .foregroundStyle(.black)
                .background(RoundedRectangle(cornerRadius: 10).foregroundStyle(.orange))
                .padding()
            }
            HStack {
                
                NavigationLink(destination: Complete()) {
                    Text("Completed")
                }
                .frame(width: 100, height: 50)
                .foregroundStyle(.black)
                .background(RoundedRectangle(cornerRadius: 10).foregroundStyle(.orange))
                .padding()
                NavigationLink(destination: VinScan()) {
                    Text("Scan Vin")
                }
                .frame(width: 100, height: 50)
                .foregroundStyle(.black)
                .background(RoundedRectangle(cornerRadius: 10).foregroundStyle(.orange))
                .padding()
            }
        }
    }
}

#Preview {
    StartPage()
}
