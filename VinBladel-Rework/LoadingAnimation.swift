//
//  LoadingAnimation.swift
//  VinBladel-Rework
//
//  Created by Matthew S. Barton on 2/10/26.
//


import SwiftUI

struct loadingAnimation: View {
    @State var isAnimating = false
    var body: some View {
        ZStack{
            Image("hersey-husky")
                .resizable()
                .frame(width: 150, height: 150)
                .padding(15)
                
            Circle()
                .trim(from: 0.23, to: 1.0)
                .stroke(
                    Color.gray,
                    style: StrokeStyle(lineWidth: 15, lineCap: .round)
                )
                .frame(width: 210, height: 210)
                .rotationEffect(.degrees(isAnimating ? 360 : 0))
                .animation(
                    .linear(duration: 1)
                    .repeatForever(autoreverses: false),
                    value: isAnimating
                )
                .onAppear() {
                    isAnimating = true
                }
        }
    }
}

#Preview {
    loadingAnimation(isAnimating: false)
}

