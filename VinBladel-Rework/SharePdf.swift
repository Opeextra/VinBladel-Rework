//
//  SharePdf.swift
//  VinBladel-Rework
//
//  Created by Aadi Shah on 2/4/26.
//

import SwiftUI
import UIKit
import MessageUI

struct ShareSheet: UIViewControllerRepresentable {
    let activityItems: [Any]
    let applicationActivities: [UIActivity]? = nil

    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

struct DocumentExporter: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let picker = UIDocumentPickerViewController(forExporting: [url])
        picker.allowsMultipleSelection = false
        return picker
    }

    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}
}

// MARK: - Demo view integrating DocumentExporter and MailView

struct DocumentExportDemoView: View {
    let url: URL
    @State private var showMailView = false
    @State private var showDocumentExporter = false
    @State private var mailUnavailableAlert = false

    var body: some View {
        VStack(spacing: 20) {
            Button("Export Document") {
                showDocumentExporter = true
            }
            .sheet(isPresented: $showDocumentExporter) {
                DocumentExporter(url: url)
            }

            if url.pathExtension.lowercased() == "pdf" {
                Button("Send via Email") {
                    if MFMailComposeViewController.canSendMail() {
                        // Debug: print when button is tapped and mail is available
                        print("Send via Email tapped. Presenting MailView.")
                        showMailView = true
                    } else {
                        // Debug: print when mail is unavailable
                        print("Mail unavailable on this device. Showing alert.")
                        mailUnavailableAlert = true
                    }
                }
                .sheet(isPresented: $showMailView) {
                    MailView(isPresented: $showMailView, attachmentURL: url)
                        .onAppear {
                            // Debug: print when MailView sheet is presented
                            print("Presenting MailView sheet for PDF: \(url.lastPathComponent)")
                        }
                }
                .alert("Mail Unavailable", isPresented: $mailUnavailableAlert) {
                    Button("OK", role: .cancel) {}
                } message: {
                    Text("Please configure a Mail account to send emails from this device.")
                }
            }
        }
        .padding()
    }
}

