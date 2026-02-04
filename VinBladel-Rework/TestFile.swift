//
//  TestFile.swift
//  VinBladel-Rework
//
//  Created by Aadi Shah on 1/7/26.
//

import SwiftUI
import MessageUI
import UIKit

import SwiftUI

struct InvoiceView: View {

    @State private var showMail = false
    @State private var pdfURL: URL?

    var body: some View {
        VStack {
            // 👇 This is what becomes the PDF
            invoiceContent

            Button("Send Invoice") {
                guard MFMailComposeViewController.canSendMail() else {
                    print("Mail not available")
                    return
                }

                if let url = PDFGenerator.generate(from: invoiceContent) {
                    pdfURL = url
                    showMail = true
                } else {
                    print("❌ PDF generation failed")
                }
            }
        }
    }

    var invoiceContent: some View {
        VStack {
            Text("Invoice #123")
                .font(.title)
            Text("Total: $120.00")
        }
        .padding()
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

//struct TestFile: View {
//    @State private var showMail: Bool = false
//    
//    var body: some View {
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
//        Button{
//            
//        }label: {
//            Text("Test PDF")
//        }
//    }
//    
//}
//
//#Preview {
//    TestFile()
//}
