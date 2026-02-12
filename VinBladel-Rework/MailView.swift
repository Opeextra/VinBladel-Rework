//
//  MailView.swift
//  VinBladel-Rework
//
//  Created by Aadi Shah on 1/16/26.
//

import SwiftUI
import MessageUI
import WebKit

struct InvoiceHTMLTemplate {
    static func makeHTML(title: String = "Invoice",
                         businessName: String = "Your Business",
                         businessAddress: String = "123 Main St, City, State",
                         invoiceNumber: String = "INV-0001",
                         invoiceDate: String = "2026-01-16",
                         billToName: String = "Customer Name",
                         billToAddress: String = "456 Customer Rd, City, State",
                         items: [(description: String, qty: Int, unitPrice: Double)] = [("Service", 1, 100.0)],
                         notes: String = "Thank you for your business!") -> String {
        let currencyFormatter: NumberFormatter = {
            let f = NumberFormatter()
            f.numberStyle = .currency
            return f
        }()

        func money(_ value: Double) -> String {
            currencyFormatter.string(from: NSNumber(value: value)) ?? String(format: "$%.2f", value)
        }

        let rows = items.map { item -> String in
            let lineTotal = Double(item.qty) * item.unitPrice
            return """
            <tr>
                <td>\(item.description)</td>
                <td class=\"right\">\(item.qty)</td>
                <td class=\"right\">\(money(item.unitPrice))</td>
                <td class=\"right\">\(money(lineTotal))</td>
            </tr>
            """
        }.joined(separator: "\n")

        let subtotal = items.reduce(0.0) { $0 + Double($1.qty) * $1.unitPrice }
        let taxRate = 0.0
        let tax = subtotal * taxRate
        let total = subtotal + tax

        return """
        <!DOCTYPE html>
        <html lang=\"en\">
        <head>
            <meta charset=\"utf-8\" />
            <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\" />
            <title>\(title)</title>
            <style>
                :root { --fg: #111; --muted: #666; --accent: #0a84ff; }
                * { box-sizing: border-box; }
                body { font-family: -apple-system, BlinkMacSystemFont, \"SF Pro Text\", Helvetica, Arial, sans-serif; color: var(--fg); margin: 0; padding: 24px; }
                .container { max-width: 800px; margin: 0 auto; }
                header { display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 24px; }
                h1 { font-size: 28px; margin: 0 0 8px 0; }
                .muted { color: var(--muted); }
                .section { border: 1px solid #e5e5ea; border-radius: 12px; padding: 16px; margin-bottom: 16px; }
                table { width: 100%; border-collapse: collapse; }
                th, td { text-align: left; padding: 10px; border-bottom: 1px solid #e5e5ea; }
                th { background: #f8f8f8; font-weight: 600; }
                .right { text-align: right; }
                .totals { margin-top: 12px; }
                .totals .row { display: flex; justify-content: flex-end; gap: 24px; padding: 6px 0; }
                .badge { display: inline-block; padding: 2px 8px; border-radius: 999px; background: #e6f0ff; color: var(--accent); font-weight: 600; font-size: 12px; }
                footer { margin-top: 24px; font-size: 12px; color: var(--muted); text-align: center; }
            </style>
        </head>
        <body>
            <div class=\"container\">
                <header>
                    <div>
                        <h1>\(businessName)</h1>
                        <div class=\"muted\">\(businessAddress)</div>
                    </div>
                    <div class=\"right\">
                        <div class=\"badge\">\(title.uppercased())</div>
                        <div class=\"muted\">No. \(invoiceNumber)</div>
                        <div class=\"muted\">Date: \(invoiceDate)</div>
                    </div>
                </header>

                <div class=\"section\">
                    <strong>Bill To</strong>
                    <div>\(billToName)</div>
                    <div class=\"muted\">\(billToAddress)</div>
                </div>

                <div class=\"section\">
                    <table>
                        <thead>
                            <tr>
                                <th>Description</th>
                                <th class=\"right\">Qty</th>
                                <th class=\"right\">Unit Price</th>
                                <th class=\"right\">Amount</th>
                            </tr>
                        </thead>
                        <tbody>
                            \(rows)
                        </tbody>
                    </table>

                    <div class=\"totals\">
                        <div class=\"row\"><div>Subtotal</div><div class=\"right\">\(money(subtotal))</div></div>
                        <div class=\"row\"><div>Tax</div><div class=\"right\">\(money(tax))</div></div>
                        <div class=\"row\" style=\"font-weight:700\"><div>Total</div><div class=\"right\">\(money(total))</div></div>
                    </div>
                </div>

                <div class=\"section\">
                    <strong>Notes</strong>
                    <div class=\"muted\">\(notes)</div>
                </div>

                <footer>
                    Generated by your app.
                </footer>
            </div>
        </body>
        </html>
        """
    }
}

final class HTMLToPDFRenderer: NSObject, WKNavigationDelegate {
    private var webView: WKWebView?
    private var completion: ((Result<URL, Error>) -> Void)?
    private var fileName: String = "document.pdf"

    enum RenderError: Error { case loadFailed, renderFailed }

    func render(html: String, fileName: String = "document.pdf", completion: @escaping (Result<URL, Error>) -> Void) {
        self.completion = completion
        self.fileName = fileName
        let config = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.navigationDelegate = self
        self.webView = webView
        webView.loadHTMLString(html, baseURL: nil)
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        let fmt = UISimpleTextPrintFormatter(text: "")
        fmt.perPageContentInsets = .zero
        let pdfRenderer = UIGraphicsPDFRenderer(bounds: CGRect(x: 0, y: 0, width: 612, height: 792)) // US Letter 8.5x11 @72dpi

        // Take a snapshot of the web content size by fitting it vertically
        webView.evaluateJavaScript("document.body.scrollHeight") { [weak self] result, error in
            guard let self = self else { return }
            guard error == nil, let height = result as? CGFloat else {
                self.finish(.failure(RenderError.renderFailed))
                return
            }
            let contentHeight = max(792, height)
            let pageRect = CGRect(x: 0, y: 0, width: 612, height: 792)
            let pages = Int(ceil(contentHeight / pageRect.height))

            let pdfURL = FileManager.default.temporaryDirectory.appendingPathComponent(self.fileName)
            do {
                try pdfRenderer.writePDF(to: pdfURL, withActions: { ctx in
                    for page in 0..<pages {
                        ctx.beginPage()
                        let yOffset = CGFloat(page) * pageRect.height
                        webView.scrollView.setContentOffset(CGPoint(x: 0, y: yOffset), animated: false)
                        webView.drawHierarchy(in: pageRect, afterScreenUpdates: true)
                    }
                })
                self.finish(.success(pdfURL))
            } catch {
                self.finish(.failure(error))
            }
        }
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        finish(.failure(error))
    }

    private func finish(_ result: Result<URL, Error>) {
        completion?(result)
        completion = nil
        webView = nil
    }
}

struct MailView: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    /// If you already have a PDF file URL, provide it here.
    let attachmentURL: URL?
    /// Alternatively, provide HTML and a filename to render a PDF on the fly.
    let htmlContent: String?
    let outputFileName: String

    init(isPresented: Binding<Bool>, attachmentURL: URL) {
        self._isPresented = isPresented
        self.attachmentURL = attachmentURL
        self.htmlContent = nil
        self.outputFileName = attachmentURL.lastPathComponent
    }

    init(isPresented: Binding<Bool>, htmlContent: String, outputFileName: String = "invoice.pdf") {
        self._isPresented = isPresented
        self.attachmentURL = nil
        self.htmlContent = htmlContent
        self.outputFileName = outputFileName
    }

    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let vc = MFMailComposeViewController()
        vc.mailComposeDelegate = context.coordinator
        vc.setSubject("Invoice")
        vc.setMessageBody("Please find the attached invoice.", isHTML: false)

        // Attach existing PDF if provided; otherwise render HTML to PDF.
        if let url = attachmentURL {
            do {
                let data = try Data(contentsOf: url)
                vc.addAttachmentData(data, mimeType: "application/pdf", fileName: url.lastPathComponent)
                print("📎 Attached existing PDF: \(url.lastPathComponent)")
            } catch {
                print("❌ Failed to read PDF at \(url): \(error.localizedDescription)")
            }
        } else if let html = htmlContent {
            let renderer = HTMLToPDFRenderer()
            renderer.render(html: html, fileName: outputFileName) { result in
                switch result {
                case .success(let pdfURL):
                    do {
                        let data = try Data(contentsOf: pdfURL)
                        vc.addAttachmentData(data, mimeType: "application/pdf", fileName: pdfURL.lastPathComponent)
                        print("📎 Generated & attached PDF: \(pdfURL.lastPathComponent)")
                    } catch {
                        print("❌ Failed to read generated PDF at \(pdfURL): \(error.localizedDescription)")
                    }
                case .failure(let error):
                    print("❌ Failed to render HTML to PDF: \(error.localizedDescription)")
                }
            }
        } else {
            print("⚠️ No attachmentURL or htmlContent provided; sending email without attachment.")
        }

        return vc
    }

    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {}
    func makeCoordinator() -> Coordinator {
        Coordinator(isPresented: $isPresented)
    }

    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        @Binding var isPresented: Bool

        init(isPresented: Binding<Bool>) {
            _isPresented = isPresented
        }

        func mailComposeController(_ controller: MFMailComposeViewController,
                                   didFinishWith result: MFMailComposeResult,
                                   error: Error?) {
            if let error = error {
                print("✉️ Mail compose error: \(error.localizedDescription)")
            } else {
                print("✉️ Mail compose finished with result: \(result)")
            }
            controller.dismiss(animated: true) {
                self.isPresented = false
            }
        }
    }
}

