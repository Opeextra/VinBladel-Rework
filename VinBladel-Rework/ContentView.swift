//
//  ContentView.swift
//  VinBladel-Rework
//
//  Created by Matthew S. Barton on 12/9/25.
//

import SwiftUI

struct ContentView: View {
    @State var scannedVIN: String? = nil
    var body: some View {
        NavigationStack(){
            Text("VINBladel")
                .font(.largeTitle)
                .padding()
            Text("By Jacob Caulfield, Aadi Shah, and Matthew Barton")
                .font(.subheadline.italic())
            Divider()
            ZStack{
//                NavigationLink("Scan Vin", destination: )
//                    .font(.custom("college" , size: 50))
                
            }
            
            NavigationLink("Client Details", destination: ClientDetailsView())
            Divider()
            ASECertTwitterHandleView()
            
            
        }
    }
}
#Preview {
  ContentView()
}
