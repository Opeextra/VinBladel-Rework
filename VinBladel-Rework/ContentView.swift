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
      Text("VINBladel")
            .font(.largeTitle)
            .padding()
        Text("By Jacob Caulfield, Aadi Shah, and Matthew Barton")
            .font(.subheadline.italic())
        Divider()
        NavigationStack(){
            NavigationLink("VINScanner", destination: AddVINView(scannedVIN: $scannedVIN))
        }
    }
}

#Preview {
    ContentView(scannedVIN: nil)
}
