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
    @State var isPressed1 = false
    @State var isPressed2 = false
    @State var isPressed3 = false
    @State var isPressed4 = false
    @State var isPressed5 = false
    @State var isPressed6 = false
    var body: some View {
        NavigationStack{
            HStack{
                VStack {
                    NavigationLink(destination: InvoiceView()) {
                        Text("Invoice Test")
                            .foregroundStyle(.black)
                            .frame(width: 100, height: 25)
                            .background(RoundedRectangle(cornerRadius: 10).foregroundStyle(.orange))
                            .scaleEffect(isPressed1 ? 0.92 : 1.0)
                            .animation(.spring(response: 0.25, dampingFraction: 0.6, blendDuration: 0.2), value: isPressed1)
                    }
                    .simultaneousGesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { _ in isPressed1 = true }
                            .onEnded { _ in isPressed1 = false }
                    )
                    NavigationLink(destination: Existing()) {
                        Text("Existing")
                            .foregroundStyle(.black)
                            .frame(width: 100, height: 25)
                            .background(RoundedRectangle(cornerRadius: 10).foregroundStyle(.orange))
                            .scaleEffect(isPressed2 ? 0.92 : 1.0)
                            .animation(.spring(response: 0.25, dampingFraction: 0.6, blendDuration: 0.2), value: isPressed2)
                    }
                    .simultaneousGesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { _ in isPressed2 = true }
                            .onEnded { _ in isPressed2 = false }
                    )
                   
                    NavigationLink(destination: InProgress()) {
                        Text("In Progress")
                            .foregroundStyle(.black)
                            .frame(width: 100, height: 25)
                            .background(RoundedRectangle(cornerRadius: 10).foregroundStyle(.orange))
                            .scaleEffect(isPressed3 ? 0.92 : 1.0)
                            .animation(.spring(response: 0.25, dampingFraction: 0.6, blendDuration: 0.2), value: isPressed3)
                    }
                    .simultaneousGesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { _ in isPressed3 = true }
                            .onEnded { _ in isPressed3 = false }
                    )
                    
                }
                VStack {
                    NavigationLink(destination: Complete()) {
                        Text("Completed")
                            .foregroundStyle(.black)
                            .frame(width: 100, height: 25)
                            .background(RoundedRectangle(cornerRadius: 10).foregroundStyle(.orange))
                            .scaleEffect(isPressed4 ? 0.92 : 1.0)
                            .animation(.spring(response: 0.25, dampingFraction: 0.6, blendDuration: 0.2), value: isPressed4)
                    }
                    .simultaneousGesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { _ in isPressed4 = true }
                            .onEnded { _ in isPressed4 = false }
                    )
                    NavigationLink(destination: AddVINView(scannedVIN: $scannedVin)) {
                        Text("Scan Vin")
                            .foregroundStyle(.black)
                            .frame(width: 100, height: 25)
                            .background(RoundedRectangle(cornerRadius: 10).foregroundStyle(.orange))
                            .scaleEffect(isPressed5 ? 0.92 : 1.0)
                            .animation(.spring(response: 0.25, dampingFraction: 0.6, blendDuration: 0.2), value: isPressed5)
                    }
                    .simultaneousGesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { _ in isPressed5 = true }
                            .onEnded { _ in isPressed5 = false }
                    )
                    NavigationLink(destination: PartsandServices()) {
                        Text("Services")
                            .foregroundStyle(.black)
                            .frame(width: 100, height: 25)
                            .background(RoundedRectangle(cornerRadius: 10).foregroundStyle(.orange))
                            .scaleEffect(isPressed6 ? 0.92 : 1.0)
                            .animation(.spring(response: 0.25, dampingFraction: 0.6, blendDuration: 0.2), value: isPressed6)
                    }
                    .simultaneousGesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { _ in isPressed6 = true }
                            .onEnded { _ in isPressed6 = false }
                    )
                }
            }
            .scaleEffect(3)
            //MARK: Font
            .font(.custom("Avenir Next", size: 16))
        }
        Divider()
        ASECertView()
            .frame(maxHeight: 150)
    }
}

#Preview {
    StartPage()
}
