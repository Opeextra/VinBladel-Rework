//
//  TestFile.swift
//  VinBladel-Rework
//
//  Created by Aadi Shah on 1/7/26.
//

import SwiftUI
import MessageUI

struct TestFile: View {
    @State private var showMail: Bool = false
    
    var body: some View {
        Button{
            showMail = true
        }label: {
            Label("Send Mail", systemImage: "envelope")
        }
    }
    func generateInvoice(from view: UIView) -> URL? {
        let renderer = UIGraphicsImageRenderer(bounds: view.bounds)
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0] .appendingPathComponent("invoice.pdf")
        do{
            try renderer.writeP
                
            }
        }
    }
    func emailInvoice(pdfURL: URL, presenter: UIViewController) {
        guard MFMailComposeViewController.canSendMail() else {
            print("Mail Not configured")
            return
        }
        let mailVC = MFMailComposeViewController()
        mailVC.mailComposeDelegate = presenter as? MFMailComposeViewControllerDelegate
        
        mailVC.setToRecipients(["ashah8399@stu.d214.org"])
        mailVC.setSubject("invoice")
        mailVC.setMessageBody("Hello", isHTML: false)
    }
}

#Preview {
    TestFile()
}
