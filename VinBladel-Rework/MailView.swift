//
//  MailView.swift
//  VinBladel-Rework
//
//  Created by Aadi Shah on 1/16/26.
//

import SwiftUI
import MessageUI

struct MailView : UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let mailVC = MFMailComposeViewController()
        mailVC.setToRecipients(["ashah8399@stu.d214.org"])
        mailVC.setSubject("invoice")
        mailVC.setMessageBody("Hello", isHTML: false)
        mailVC.mailComposeDelegate = context.coordinator
        return mailVC
    }
    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        let parent : MailView
        init(parent: MailView) {
            self.parent = parent
        }
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            parent.isPresented = false
        }
    }
}
