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
enum PDFGenerator {

    static func generate<Content: View>(
        from view: Content,
        fileName: String = "Invoice.pdf"
    ) -> URL? {

        let pageSize = CGSize(width: 612, height: 792) // US Letter

        let controller = UIHostingController(rootView: view)
        controller.view.bounds = CGRect(origin: .zero, size: pageSize)
        controller.view.backgroundColor = .white

        // 🔥 Force layout
        controller.view.layoutIfNeeded()

        let renderer = UIGraphicsPDFRenderer(bounds: controller.view.bounds)

        let url = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent(fileName)

        do {
            try renderer.writePDF(to: url) { context in
                context.beginPage()
                controller.view.layer.render(in: context.cgContext)
            }
            return url
        } catch {
            print("PDF error:", error)
            return nil
        }
    }
}
