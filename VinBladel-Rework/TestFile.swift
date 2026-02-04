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
    @State private var showShare = false
    @State private var showExporter = false
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
                    showExporter = true // Present Document Picker
                } else {
                    print("❌ PDF generation failed")
                }
            }
            // Share sheet
            .sheet(isPresented: $showShare) {
                if let url = pdfURL {
                    ShareSheet(activityItems: [url])
                } else {
                    Text("No PDF available")
                }
            }

            // Files export picker
            .sheet(isPresented: $showExporter) {
                if let url = pdfURL {
                    DocumentExporter(url: url)
                } else {
                    Text("No PDF available")
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

