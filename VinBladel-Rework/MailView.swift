//
//  MailView.swift
//  VinBladel-Rework
//
//  Created by Aadi Shah on 1/16/26.
//

import SwiftUI
import MessageUI
import UIKit

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







//struct MailView : UIViewControllerRepresentable {
//    @Binding var isPresented: Bool
//    
//    func makeUIViewController(context: Context) -> MFMailComposeViewController {
//        let mailVC = MFMailComposeViewController()
//        mailVC.setToRecipients(["ashah8399@stu.d214.org"])
//        mailVC.setSubject("invoice")
//        if let pdfData = try? Data(contentsOf: pdfURL) {
//               mailVC.addAttachmentData(
//                   pdfData,
//                   mimeType: "application/pdf",
//                   fileName: "Invoice.pdf"
//               )
//           }
//        mailVC.mailComposeDelegate = context.coordinator
//        return mailVC
//    }
//    
//    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {}
//    
//    func makeCoordinator() -> Coordinator {
//        Coordinator(parent: self)
//    }
//    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
//        let parent : MailView
//        init(parent: MailView) {
//            self.parent = parent
//        }
//        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
//            parent.isPresented = false
//        }
//    }
//}
