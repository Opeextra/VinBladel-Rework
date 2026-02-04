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
                .frame(width: 250, height: 250)
                .padding(100)
            Image("AutomotiveTech")
                .resizable()
                .frame(width: 250, height: 132.5)
                .padding(50)
        }
       
        .padding()
    }
}

#Preview {
    ASECertTwitterHandleView()
}
