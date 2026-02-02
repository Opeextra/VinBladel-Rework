//
//  MailView.swift
//  VinBladel-Rework
//
//  Created by Aadi Shah on 1/16/26.
//

import SwiftUI
import MessageUI

struct MailView: UIViewControllerRepresentable {

    let pdfURL: URL

    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let mailVC = MFMailComposeViewController()
        mailVC.mailComposeDelegate = context.coordinator

        mailVC.setSubject("Your Invoice")
        mailVC.setMessageBody("Please find your invoice attached.", isHTML: false)

        if let data = try? Data(contentsOf: pdfURL) {
            mailVC.addAttachmentData(
                data,
                mimeType: "application/pdf",
                fileName: "Invoice.pdf"
            )
        }

        return mailVC
    }

    func updateUIViewController(
        _ uiViewController: MFMailComposeViewController,
        context: Context
    ) {}

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        func mailComposeController(
            _ controller: MFMailComposeViewController,
            didFinishWith result: MFMailComposeResult,
            error: Error?
        ) {
            controller.dismiss(animated: true)
        }
    }
}
