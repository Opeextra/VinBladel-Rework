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
                MailView()
            }else{
                Text("Not Available")
            }
        }
    }
    //    func generateInvoice(from view: UIView) -> URL? {
    //        let renderer = UIGraphicsImageRenderer(bounds: view.bounds)
    //        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0] .appendingPathComponent("invoice.pdf")
    //        do{
    //            try renderer.;{ ctx in
    //
    //            }
    //
    //            }
    //        }
    //    }
    
}
#Preview {
    TestFile()
}
