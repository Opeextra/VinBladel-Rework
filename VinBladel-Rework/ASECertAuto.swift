//
//  ASECertAuto.swift
//  VinBladel-Rework
//
//  Created by Jacob M. Caulfield on 12/17/25.
//
import SwiftUI

struct ASECertView: View {
    var body: some View {
        HStack{
            Image("ASECertified")
                .resizable()
                .scaledToFill()
                .frame(width: 187)
                .padding(100)
            Image("AutomotiveTech")
                .resizable()
                .padding(50)
                .frame(height: 200)
        }
       
        .padding()
}
}
#Preview {
    StartPage()
}
