//
//  TestFile.swift
//  VinBladel-Rework
//
//  Created by Aadi Shah on 1/7/26.
//

import SwiftUI
import MessageUI
import UIKit

struct InvoiceView: View {

    @State private var showMail = false
    @State private var pdfURL: URL?
    @State private var showShare = false
    @State private var showExporter = false
    @State private var showMailUnavailableAlert = false
    @State private var shareItem: URL?

    var body: some View {
        VStack {
            // 👇 This is what becomes the PDF
            invoiceContent

            Button("Send Invoice") {
                  if let url = PDFGenerator.generate(from: invoiceContent) {
                      print("✅ PDF generated at: \(url.path)")
                      // Ensure file exists
                      if FileManager.default.fileExists(atPath: url.path) {
                          pdfURL = url
                          if MFMailComposeViewController.canSendMail() {
                              // Present mail sheet synchronously after pdfURL is set
                              print("Presenting Mail composer. pdfURL = \(pdfURL?.path ?? "nil")")
                              showMail = true
                          } else {
                              // Fallbacks when Mail isn't available
                              shareItem = url
                              showMailUnavailableAlert = true
                          }
                      } else {
                          print("❌ PDF file missing right after generation")
                      }
                  } else {
                      print("❌ PDF generation failed")
                  }
              }
              .sheet(isPresented: $showMail) {
                  if let url = pdfURL {
                      MailView(isPresented: $showMail, attachmentURL: url)
                  } else {
                      Text("No PDF available")
                  }
              }
              .alert("Mail not available", isPresented: $showMailUnavailableAlert) {
                  Button("Share Instead") {
                      if let url = pdfURL { shareItem = url }
                  }
                  Button("Export to Files") {
                      if pdfURL != nil { showExporter = true }
                  }
                  Button("OK", role: .cancel) { }
              } message: {
                  Text("This device can't send email. You can share or export the PDF instead.")
              }
            if let shareURL = shareItem {
                ShareLink(item: shareURL) {
                    Label("Share Invoice PDF", systemImage: "square.and.arrow.up")
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

