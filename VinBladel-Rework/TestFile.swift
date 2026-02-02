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
                pdfURL = PDFGenerator.generate(from: invoiceContent)
                showMail = pdfURL != nil
            }
            .padding()
        }
        .sheet(isPresented: $showMail) {
            if let pdfURL {
                MailView(pdfURL: pdfURL)
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
        from view: Content
    ) -> URL? {

        let controller = UIHostingController(rootView: view)
        controller.view.bounds = CGRect(x: 0, y: 0, width: 612, height: 792)

        let renderer = UIGraphicsPDFRenderer(bounds: controller.view.bounds)

        let url = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("Invoice.pdf")

        do {
            try renderer.writePDF(to: url) { context in
                context.beginPage()
                controller.view.layer.render(in: context.cgContext)
            }
            return url
        } catch {
            print(error)
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
