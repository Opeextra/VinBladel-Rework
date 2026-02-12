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
                .padding(100)
            Image("AutomotiveTech")
                .resizable()
                .padding(50)
                .scaledToFill()
        }
       
        .padding()
}
}
#Preview {
    StartPage()
}
