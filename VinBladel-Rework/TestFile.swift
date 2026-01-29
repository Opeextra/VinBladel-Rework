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
//    @State private var showMail: Bool = false
    
    var body: some View {
//        Button{
//            showMail = true
//        }label: {
//            Label("Send Mail", systemImage: "envelope")
//        }
//        .sheet(isPresented: $showMail) {
//            if MFMailComposeViewController.canSendMail(){
//                MailView(isPresented: $showMail)
//            }else{
//                Text("Not Available")
//            }
//        }
        Button{
            
        }label: {
            Text("Test PDF")
        }
    }
    func generateInvoicePDF(from view: UIView) -> URL? {
        let renderer = UIGraphicsPDFRenderer(bounds: view.bounds)

        let url = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("Invoice.pdf")

        do {
            try renderer.writePDF(to: url) { context in
                context.beginPage()
                view.layer.render(in: context.cgContext)
            }
            return url
        } catch {
            print(error)
            return nil
        }
    }
}

#Preview {
    TestFile()
}
