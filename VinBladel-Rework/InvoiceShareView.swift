import SwiftUI
import UIKit

struct ActivityViewController: UIViewControllerRepresentable {
    let activityItems: [Any]
    let applicationActivities: [UIActivity]?
    var completion: UIActivityViewController.CompletionWithItemsHandler?

    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        controller.completionWithItemsHandler = completion
        controller.popoverPresentationController?.sourceView = UIApplication.shared.connectedScenes
            .compactMap { ($0 as? UIWindowScene)?.keyWindow }
            .first
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        // No update needed
    }
}

public struct InvoiceShareView: View {
    private let shareItems: [Any]

    @State private var showActivity = false

    public init(data: Data, filename: String, typeHint: String? = nil) {
        if let url = Self.createTemporaryFile(with: data, filename: filename) {
            self.shareItems = [url]
        } else {
            self.shareItems = [data]
        }
    }

    public init(url: URL) {
        self.shareItems = [url]
    }

    public init(string: String) {
        self.shareItems = [string]
    }

    public var body: some View {
        HStack {
            if #available(iOS 16.0, *) {
                if shareItems.count == 1, let url = shareItems.first as? URL {
                    ShareLink(item: url)
                } else {
                    Button {
                        showActivity = true
                    } label: {
                        Label("Share", systemImage: "square.and.arrow.up")
                    }
                    .buttonStyle(PressableButtonStyle())
                }
            } else {
                Button {
                    showActivity = true
                } label: {
                    Label("Share", systemImage: "square.and.arrow.up")
                }
                .buttonStyle(PressableButtonStyle())
            }

            Button {
                showActivity = true
            } label: {
                Label("More…", systemImage: "square.and.arrow.up")
            }
            .buttonStyle(PressableButtonStyle())
            .sheet(isPresented: $showActivity) {
                ActivityViewController(activityItems: shareItems, applicationActivities: nil)
            }
        }
    }

    private static func createTemporaryFile(with data: Data, filename: String) -> URL? {
        let caches = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        guard let cacheDir = caches else { return nil }
        let tempFileURL = cacheDir.appendingPathComponent(filename)
        do {
            try data.write(to: tempFileURL, options: .atomic)
            return tempFileURL
        } catch {
            return nil
        }
    }
}

#Preview {
    // Prepare a temporary PDF URL for preview purposes
    let tempPDF: URL? = {
        let caches = try? FileManager.default.url(for: .cachesDirectory,
                                                  in: .userDomainMask,
                                                  appropriateFor: nil,
                                                  create: true)
        guard let base = caches else { return nil }
        let url = base.appendingPathComponent("sample.pdf")
        // create a dummy PDF file if not exists
        if !FileManager.default.fileExists(atPath: url.path) {
            let dummyPDFData = Data([0x25, 0x50, 0x44, 0x46, 0x2d]) // "%PDF-" header
            try? dummyPDFData.write(to: url)
        }
        return url
    }()

    return VStack(spacing: 20) {
        InvoiceShareView(string: "This is a sample invoice text to share.")
        if let tempPDF {
            InvoiceShareView(url: tempPDF)
        } else {
            // Fallback to a string share if temp URL couldn't be created
            InvoiceShareView(string: "Fallback: could not create temp PDF.")
        }
    }
    .padding()
}
