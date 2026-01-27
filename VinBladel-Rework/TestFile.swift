//
//  TestFile.swift
//  VinBladel-Rework
//
//  Created by Aadi Shah on 1/7/26.
//

import SwiftUI
import MessageUI
import UIKit

struct TestFile: View {
    @State private var showMail: Bool = false
    
    var body: some View {
        Button{
            showMail = true
        }label: {
            Label("Send Mail", systemImage: "envelope")
        }
        .sheet(isPresented: $showMail) {
            if MFMailComposeViewController.canSendMail(){
                MailView(isPresented: $showMail)
            }else{
                Text("Not Available")
            }
        }
    }
}
#Preview {
    TestFile()
}
