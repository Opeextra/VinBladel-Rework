//
//  MailView.swift
//  VinBladel-Rework
//
//  Created by Aadi Shah on 1/16/26.
//

import SwiftUI
import MessageUI
import UIKit

class MailView: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var invoiceView: UIView!
    @IBAction func sendInvoiceTapped(_ sender: UIButton) {
        if let pdfURL = generateInvoicePDF(from: invoiceView) {
            emailInvoice(pdfURL: pdfURL)
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

    func emailInvoice(pdfURL: URL) {
        guard MFMailComposeViewController.canSendMail() else {
            print("Mail not set up")
            return
        }

        let mailVC = MFMailComposeViewController()
        mailVC.mailComposeDelegate = self

        mailVC.setToRecipients(["customer@email.com"])
        mailVC.setSubject("Your Invoice")
        mailVC.setMessageBody(
            "Hello,\n\nPlease find your invoice attached.\n\nThank you!",
            isHTML: false
        )

        if let pdfData = try? Data(contentsOf: pdfURL) {
            mailVC.addAttachmentData(
                pdfData,
                mimeType: "application/pdf",
                fileName: "Invoice.pdf"
            )
        }

        present(mailVC, animated: true)
    }

    // MARK: - Mail Delegate
    func mailComposeController(
        _ controller: MFMailComposeViewController,
        didFinishWith result: MFMailComposeResult,
        error: Error?
    ) {
        controller.dismiss(animated: true)
    }
}
