//
//  MailView.swift
//  VinBladel-Rework
//
//  Created by Aadi Shah on 1/16/26.
//

import SwiftUI
import MessageUI
import WebKit

struct MailView: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    /// If you already have a PDF file URL, provide it here.
    let attachmentURL: URL?

    init(isPresented: Binding<Bool>, attachmentURL: URL) {
        self._isPresented = isPresented
        self.attachmentURL = attachmentURL
    }

    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let vc = MFMailComposeViewController()
        vc.mailComposeDelegate = context.coordinator
        vc.setSubject("Invoice")
        vc.setMessageBody("Please find the attached invoice.", isHTML: false)

        // Attach existing PDF if provided.
        if let url = attachmentURL {
            do {
                let data = try Data(contentsOf: url)
                vc.addAttachmentData(data, mimeType: "application/pdf", fileName: url.lastPathComponent)
                print("📎 Attached existing PDF: \(url.lastPathComponent)")
            } catch {
                print("❌ Failed to read PDF at \(url): \(error.localizedDescription)")
            }
        } else {
            print("⚠️ No attachmentURL provided; sending email without attachment.")
        }

        return vc
    }

    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {}
    func makeCoordinator() -> Coordinator {
        Coordinator(isPresented: $isPresented)
    }

    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        @Binding var isPresented: Bool

        init(isPresented: Binding<Bool>) {
            _isPresented = isPresented
        }

        func mailComposeController(_ controller: MFMailComposeViewController,
                                   didFinishWith result: MFMailComposeResult,
                                   error: Error?) {
            if let error = error {
                print("✉️ Mail compose error: \(error.localizedDescription)")
            } else {
                print("✉️ Mail compose finished with result: \(result)")
            }
            controller.dismiss(animated: true) {
                self.isPresented = false
            }
        }
    }
}

