//
//  VinBladel_ReworkApp.swift
//  VinBladel-Rework
//
//  Created by Matthew S. Barton on 12/9/25.
//

import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct VinBladel_ReworkApp: App {
    @State var launchScreen: Bool = false
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            Group {
                if launchScreen == true {
                    StartPage()
                        .transition(.slide)
                } else {
                    loadingAnimation()
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation {
                                    self.launchScreen = true
                                    // Make it so the firebase realtime database loads during this time
                                }
                            }
                        }
                }
            }
            .preferredColorScheme(.light)
        }
    }
        
}
