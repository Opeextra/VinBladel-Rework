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
        VStack(spacing: 16) {
            // 👇 This is what becomes the PDF (smaller size, centered)
            invoiceContent
                .background(Color.white)
                .cornerRadius(8)
                .shadow(radius: 2)
        }
        .padding()
    }

    var invoiceContent: some View {
        VStack(spacing: 16) {
            InvoiceTemplateView(
                business: .init(
                    name: "Vin Bladel Auto Repair",
                    addressLines: [
                        "1234 Main Street",
                        "San Jose, CA 95123"
                    ],
                    phone: "(408) 555-1212",
                    email: "service@vinbladel.com"
                ),
                customer: .init(
                    name: "John Appleseed",
                    addressLines: [
                        "1 Infinite Loop",
                        "Cupertino, CA 95014"
                    ],
                    phone: "(408) 555-0000"
                ),
                items: [
                    .init(description: "Oil Change (Synthetic)", quantity: 1, unitPrice: 89.99),
                    .init(description: "Brake Pad Replacement - Front", quantity: 1, unitPrice: 249.00),
                    .init(description: "Tire Rotation", quantity: 1, unitPrice: 39.00)
                ],
                summary: .init(
                    subtotal: 89.99 + 249.00 + 39.00,
                    tax: (89.99 + 249.00 + 39.00) * 0.0925,
                    discount: 0.00,
                    total: (89.99 + 249.00 + 39.00) * (1 + 0.0925)
                ),
                meta: .init(number: "INV-2026-00123", date: Date(), dueDate: Calendar.current.date(byAdding: .day, value: 15, to: Date())),
                notes: "Thank you for your business! Payment is due within 15 days.",
                accentColor: .orange
            )
            .background(Color.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(0)
    }

}

