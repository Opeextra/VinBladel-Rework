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
        // Precompute values to help the type-checker and match InvoiceTemplateView API
        let businessAddress = [
            "1234 Main Street",
            "San Jose, CA 95123"
        ]
        let customerAddress = [
            "1 Infinite Loop",
            "Cupertino, CA 95014"
        ]

        // Explicitly type items and use Decimal for currency values
        let items: [InvoiceItem] = [
            InvoiceItem(description: "Oil Change (Synthetic)", quantity: 1, unitPrice: Decimal(string: "89.99")!),
            InvoiceItem(description: "Brake Pad Replacement - Front", quantity: 1, unitPrice: Decimal(string: "249.00")!),
            InvoiceItem(description: "Tire Rotation", quantity: 1, unitPrice: Decimal(string: "39.00")!)
        ]

        // Compute summary using Decimal arithmetic
        let subtotal = items.reduce(Decimal.zero) { $0 + $1.total }
        let taxRate = Decimal(string: "0.0925")!
        let tax = subtotal * taxRate
        let discount = Decimal.zero
        let total = subtotal + tax - discount

        let now = Date()
        let dueDate = Calendar.current.date(byAdding: .day, value: 15, to: now)

        // Build model objects expected by the view model
        let business = InvoiceBusinessInfo(
            name: "Vin Bladel Auto Repair",
            addressLines: businessAddress,
            phone: "(408) 555-1212",
            email: "service@vinbladel.com"
        )
        let customer = InvoiceCustomerInfo(
            name: "John Appleseed",
            addressLines: customerAddress,
            phone: "(408) 555-0000"
        )
        let summary = InvoiceSummary(subtotal: subtotal, tax: tax, discount: discount, total: total)
        let meta = InvoiceMeta(number: "INV-2026-00123", date: now, dueDate: dueDate)

        let viewModel = InvoiceViewModel(
            business: business,
            customer: customer,
            items: items,
            summary: summary,
            meta: meta,
            notes: "Thank you for your business! Payment is due within 15 days."
        )

        return VStack(spacing: 16) {
            InvoiceTemplateView(viewModel: viewModel, accentColor: .orange)
                .background(Color.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(0)
    }

}

