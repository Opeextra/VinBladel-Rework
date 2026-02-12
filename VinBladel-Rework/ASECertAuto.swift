//
//  ASECertAuto.swift
//  VinBladel-Rework
//
//  Created by Jacob M. Caulfield on 12/17/25.
//
import SwiftUI

struct ASECertTwitterHandleView: View {
    var body: some View {
        HStack{
            Image("ASECertified")
                .resizable()
                .frame(width: 150, height: 150)
                .padding(100)
            Image("AutomotiveTech")
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 125)
                .padding(50)
        }
       
        .padding()
}
}

#Preview {
    ASECertTwitterHandleView()
}
