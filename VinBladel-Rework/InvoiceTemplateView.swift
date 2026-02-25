import SwiftUI
import UIKit

public struct InvoiceBusinessInfo: Equatable, Identifiable {
    public let id = UUID()
    public let name: String
    public let addressLines: [String]
    public let phone: String?
    public let email: String?
    public init(name: String, addressLines: [String], phone: String? = nil, email: String? = nil) {
        self.name = name
        self.addressLines = addressLines
        self.phone = phone
        self.email = email
    }
}

public struct InvoiceCustomerInfo: Equatable, Identifiable {
    public let id = UUID()
    public let name: String
    public let addressLines: [String]
    public let phone: String?
    public init(name: String, addressLines: [String], phone: String? = nil) {
        self.name = name
        self.addressLines = addressLines
        self.phone = phone
    }
}

public struct InvoiceItem: Equatable, Identifiable {
    public let id = UUID()
    public let description: String
    public let quantity: Int
    public let unitPrice: Decimal
    public var total: Decimal { Decimal(quantity) * unitPrice }
    public init(description: String, quantity: Int, unitPrice: Decimal) {
        self.description = description
        self.quantity = quantity
        self.unitPrice = unitPrice
    }
}

public struct InvoiceSummary: Equatable {
    public let subtotal: Decimal
    public let tax: Decimal
    public let discount: Decimal
    public let total: Decimal
    public init(subtotal: Decimal, tax: Decimal, discount: Decimal, total: Decimal) {
        self.subtotal = subtotal
        self.tax = tax
        self.discount = discount
        self.total = total
    }
}

public struct InvoiceMeta: Equatable {
    public let number: String
    public let date: Date
    public let dueDate: Date?
    public init(number: String, date: Date, dueDate: Date? = nil) {
        self.number = number
        self.date = date
        self.dueDate = dueDate
    }
}

public struct InvoiceTemplateView: View {
    public let business: InvoiceBusinessInfo
    public let customer: InvoiceCustomerInfo
    public let items: [InvoiceItem]
    public let summary: InvoiceSummary
    public let meta: InvoiceMeta
    public let notes: String?
    public let accentColor: Color

    public init(
        business: InvoiceBusinessInfo,
        customer: InvoiceCustomerInfo,
        items: [InvoiceItem],
        summary: InvoiceSummary,
        meta: InvoiceMeta,
        notes: String? = nil,
        accentColor: Color = .orange
    ) {
        self.business = business
        self.customer = customer
        self.items = items
        self.summary = summary
        self.meta = meta
        self.notes = notes
        self.accentColor = accentColor
    }

    public var body: some View {
        GeometryReader { geo in
            // A4 points at 72 DPI
            let portrait = CGSize(width: 595, height: 842)
            let landscape = CGSize(width: 842, height: 595)
            let isLandscape = geo.size.width > geo.size.height
            let target = isLandscape ? landscape : portrait
            let scale = min(geo.size.width / target.width, geo.size.height / target.height)

            ZStack {
                Color.clear
                VStack(alignment: .leading, spacing: 20) {
                    header
                    billToAndMetaSection
                    lineItemsSection
                    summarySection
                    if let notes, !notes.isEmpty {
                        notesSection
                    }
                    footerSection
                    Spacer()
                }
                .padding(24)
                .frame(width: target.width, height: target.height, alignment: .topLeading)
                .background(.background)
                .preferredColorScheme(.light)
                .scaleEffect(scale, anchor: .top)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
        .padding(.vertical, 4)
        .padding(.horizontal, 4)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    if let url = PDFGenerator.generate(from: self.frame(width: 595, height: 842)) {
                        presentShare(for: url)
                    } else {
                        presentShareFallback()
                    }
                } label: {
                    Label("Send Invoice", systemImage: "paperplane.fill")
                        .foregroundStyle(accentColor)
                }
            }
        }
    }

    private var header: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 3) {
                Text(business.name)
                    .font(.title3.weight(.bold))
                    .foregroundStyle(.primary)
                ForEach(business.addressLines, id: \.self) { line in
                    Text(line)
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
            }
            Spacer()
            Text("INVOICE")
                .font(.title2.weight(.bold))
                .foregroundStyle(accentColor)
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .fill(accentColor.opacity(0.15))
                        .blendMode(.plusDarker)
                )
                .frame(minWidth: 110, alignment: .trailing)
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(.quaternary)
        )
    }

    private var billToAndMetaSection: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 6) {
                Text("Bill To")
                    .font(.footnote.weight(.semibold))
                    .foregroundStyle(accentColor)
                Text(customer.name)
                    .font(.headline)
                    .foregroundStyle(.primary)
                ForEach(customer.addressLines, id: \.self) { line in
                    Text(line)
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
                if let phone = customer.phone, !phone.isEmpty {
                    Text(phone)
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
            }
            Spacer()
            VStack(alignment: .leading, spacing: 6) {
                labelValue("Invoice #", meta.number)
                labelValue("Date", formatDate(meta.date))
                if let due = meta.dueDate {
                    labelValue("Due Date", formatDate(due))
                }
            }
            .font(.footnote)
            .foregroundStyle(.secondary)
            .frame(minWidth: 120, alignment: .leading)
        }
    }

    private func labelValue(_ label: String, _ value: String) -> some View {
        HStack(alignment: .top, spacing: 6) {
            Text(label + ":")
                .fontWeight(.semibold)
                .foregroundStyle(accentColor)
            Text(value)
                .foregroundStyle(.primary)
        }
    }

    private var lineItemsSection: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text("Description")
                    .font(.footnote.weight(.semibold))
                    .foregroundStyle(accentColor)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("Qty")
                    .font(.footnote.weight(.semibold))
                    .foregroundStyle(accentColor)
                    .frame(width: 40, alignment: .trailing)
                Text("Unit")
                    .font(.footnote.weight(.semibold))
                    .foregroundStyle(accentColor)
                    .frame(width: 80, alignment: .trailing)
                Text("Amount")
                    .font(.footnote.weight(.semibold))
                    .foregroundStyle(accentColor)
                    .frame(width: 100, alignment: .trailing)
            }
            Divider()
                .overlay(Rectangle().frame(height: 1).foregroundStyle(accentColor.opacity(0.3)), alignment: .bottom)
                .padding(.vertical, 6)

            ForEach(items) { item in
                HStack(spacing: 0) {
                    Text(item.description)
                        .font(.footnote)
                        .foregroundStyle(.primary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("\(item.quantity)")
                        .font(.footnote.monospacedDigit())
                        .foregroundStyle(.primary)
                        .frame(width: 40, alignment: .trailing)
                    Text(formatCurrency(item.unitPrice))
                        .font(.footnote.monospacedDigit())
                        .foregroundStyle(.primary)
                        .frame(width: 80, alignment: .trailing)
                    Text(formatCurrency(item.total))
                        .font(.footnote.monospacedDigit())
                        .foregroundStyle(.primary)
                        .frame(width: 100, alignment: .trailing)
                }
                Divider()
                    .overlay(Rectangle().frame(height: 1).foregroundStyle(accentColor.opacity(0.15)), alignment: .bottom)
                    .padding(.vertical, 6)
            }
        }
    }

    private var summarySection: some View {
        VStack(spacing: 8) {
            summaryLine(label: "Subtotal", amount: summary.subtotal)
            summaryLine(label: "Tax", amount: summary.tax)
            summaryLine(label: "Discount", amount: summary.discount)
            Divider()
            summaryLine(label: "Total", amount: summary.total, isBold: true, fontSize: 20, tint: accentColor)
        }
        .frame(maxWidth: 300, alignment: .trailing)
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(.tertiary)
        )
        .foregroundStyle(.primary)
        .font(.footnote)
        .monospacedDigit()
        .frame(maxWidth: .infinity, alignment: .trailing)
    }

    private func summaryLine(label: String, amount: Decimal, isBold: Bool = false, fontSize: CGFloat? = nil, tint: Color? = nil) -> some View {
        HStack {
            Text(label)
                .foregroundStyle(tint ?? .secondary)
                .fontWeight(isBold ? .bold : .regular)
            Spacer()
            Text(formatCurrency(amount))
                .foregroundStyle(tint != nil ? tint! : .primary)
                .fontWeight(isBold ? .bold : .regular)
                .font(fontSize != nil ? .system(size: fontSize!) : .footnote.monospacedDigit())
        }
    }

    private var notesSection: some View {
        VStack(alignment: .leading, spacing: 6) {
            Divider().foregroundStyle(.quaternary)
            Text("Notes")
                .font(.footnote.weight(.semibold))
                .foregroundStyle(accentColor)
            Text(notes ?? "")
                .font(.caption)
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)
        }
    }

    private var footerSection: some View {
        VStack(spacing: 4) {
            Divider().foregroundStyle(.quaternary)
            if let email = business.email, !email.isEmpty {
                Text(email)
                    .font(.caption2)
                    .foregroundStyle(accentColor)
            }
            if let phone = business.phone, !phone.isEmpty {
                Text(phone)
                    .font(.caption2)
                    .foregroundStyle(accentColor)
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.top, 8)
    }

    private func presentShare(for url: URL) {
        let controller = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        // Find a presenting view controller
        guard let windowScene = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first,
              let window = windowScene.keyWindow,
              let root = window.rootViewController else {
            return
        }
        let presenter = root.presentedViewController ?? root
        controller.popoverPresentationController?.sourceView = presenter.view
        controller.popoverPresentationController?.sourceRect = presenter.view.bounds
        presenter.present(controller, animated: true)
    }

    private func presentShareFallback() {
        let controller = UIActivityViewController(activityItems: ["Invoice"], applicationActivities: nil)
        guard let windowScene = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first,
              let window = windowScene.keyWindow,
              let root = window.rootViewController else {
            return
        }
        let presenter = root.presentedViewController ?? root
        controller.popoverPresentationController?.sourceView = presenter.view
        controller.popoverPresentationController?.sourceRect = presenter.view.bounds
        presenter.present(controller, animated: true)
    }
}


private let currencyFormatter: NumberFormatter = {
    let f = NumberFormatter()
    f.numberStyle = .currency
    f.locale = Locale.current
    f.maximumFractionDigits = 2
    f.minimumFractionDigits = 2
    return f
}()

private func formatCurrency(_ value: Decimal) -> String {
    let nsNumber = value as NSDecimalNumber
    return currencyFormatter.string(from: nsNumber) ?? ""
}

private func formatDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .none
    return formatter.string(from: date)
}

#Preview {
    let business = InvoiceBusinessInfo(
        name: "Acme Corporation",
        addressLines: [
            "123 Main Street",
            "Springfield, IL 62704"
        ],
        phone: "(555) 123-4567",
        email: "contact@acme.com"
    )

    let customer = InvoiceCustomerInfo(
        name: "John Doe",
        addressLines: [
            "789 Elm Street",
            "Springfield, IL 62705"
        ],
        phone: "(555) 987-6543"
    )

    let items = [
        InvoiceItem(description: "Consulting Services", quantity: 10, unitPrice: Decimal(string: "150.00")!),
        InvoiceItem(description: "Website Design", quantity: 1, unitPrice: Decimal(string: "1200.00")!),
        InvoiceItem(description: "Hosting (12 months)", quantity: 12, unitPrice: Decimal(string: "10.00")!)
    ]

    let subtotal = items.reduce(Decimal.zero) { $0 + $1.total }
    let tax = subtotal * Decimal(string: "0.075")!
    let discount = Decimal(string: "100.00")!
    let total = subtotal + tax - discount

    let summary = InvoiceSummary(subtotal: subtotal, tax: tax, discount: discount, total: total)

    let meta = InvoiceMeta(number: "2026-0023", date: Date(), dueDate: Calendar.current.date(byAdding: .day, value: 30, to: Date()))

    InvoiceTemplateView(
        business: business,
        customer: customer,
        items: items,
        summary: summary,
        meta: meta,
        notes: "Thank you for your business. Please remit payment within 30 days.",
        accentColor: .orange
    )
    .frame(width: 595, height: 842)
    .background(.background)
    .preferredColorScheme(.light)
}

