//
//  MailView.swift
//  VinBladel-Rework
//
//  Created by Aadi Shah on 1/16/26.
//

import SwiftUI
import MessageUI

struct MailView : UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let mailVC = MFMailComposeViewController()
        mailVC.setToRecipients(["ashah8399@stu.d214.org"])
        mailVC.setSubject("invoice")
        mailVC.setMessageBody("Hello", isHTML: false)
        return mailVC
    }
    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            controller.dismiss(animated: true)
        }
    }
}
