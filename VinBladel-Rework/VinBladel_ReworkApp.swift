//
//  VinBladel_ReworkApp.swift
//  VinBladel-Rework
//
//  Created by Matthew S. Barton on 12/9/25.
//

import SwiftUI

@main
struct VinBladel_ReworkApp: App {
    @State var lauchScreen: Bool = false
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            if lauchScreen == true {
                StartPage()
//                ContentView()
                    .transition(.slide)
            } else {
                loadingAnimation()
                    .onAppear(){
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation() {
                                self.lauchScreen = true
                                // Make it so the firebase realtime database loads during this time
                            }
                        }
                    }
            }
        }
    }
}
