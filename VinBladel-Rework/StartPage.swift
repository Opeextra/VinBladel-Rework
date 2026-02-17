//
//  StartPage.swift
//  VinBladel-Rework
//
//  Created by Aadi Shah on 12/15/25.
//

import SwiftUI

struct StartPage: View {
//    @Environment(DatabaseViewModel.self) private var viewModel
    @State var scannedVin: String? = nil
    var body: some View {
        NavigationStack{
            HStack{
                VStack {
                    NavigationLink(destination: InvoiceView()) {
                        Text("Invoice Test")
                            .frame(width: 100, height: 25)
                            .foregroundStyle(.black)
                            .background(RoundedRectangle(cornerRadius: 10).foregroundStyle(.orange))
                            .padding()
                    }
                    NavigationLink(destination: Existing()) {
                        Text("Existing")
                            .frame(width: 100, height: 25)
                            .foregroundStyle(.black)
                            .background(RoundedRectangle(cornerRadius: 10).foregroundStyle(.orange))
                    }
                   
                    NavigationLink(destination: InProgress()) {
                        Text("In Progress")
                            .frame(width: 100, height: 25)
                            .foregroundStyle(.black)
                            .background(RoundedRectangle(cornerRadius: 10).foregroundStyle(.orange))
                            .padding()
                    }
                    
                }
                VStack {
                    NavigationLink(destination: Complete()) {
                        Text("Completed")
                            .frame(width: 100, height: 25)
                        .foregroundStyle(.black)
                        .background(RoundedRectangle(cornerRadius: 10).foregroundStyle(.orange))
                        .padding()
                    }
                    
                    NavigationLink(destination: AddVINView(scannedVIN: $scannedVin)) {
                        Text("Scan Vin")
                            .frame(width: 100, height: 25)
                            .foregroundStyle(.black)
                            .background(RoundedRectangle(cornerRadius: 10).foregroundStyle(.orange))
                    }
                    NavigationLink(destination: PartsandServices()) {
                        Text("Services")
                            .frame(width: 100, height: 25)
                            .foregroundStyle(.black)
                            .background(RoundedRectangle(cornerRadius: 10).foregroundStyle(.orange))
                            .padding()
                            
                    }
                }
            }
            .scaleEffect(3)
            //MARK: Font
            .font(.custom("Avenir Next", size: 16))
        }
        ASECertView()
            .frame(maxHeight: 175)
    }
}

#Preview {
    StartPage()
}
