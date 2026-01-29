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
            Image("AutomotiveTech")
            Link(destination: URL(string: "https://twitter.com/herseyhuskies")!) {
                Image("@HerseyAuto")
            }
        }
        .padding()
    }
}

#Preview {
    ASECertTwitterHandleView()
}
