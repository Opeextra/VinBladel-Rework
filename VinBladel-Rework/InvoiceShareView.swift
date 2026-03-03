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
    @Environment(\.dismiss) private var dismiss
    
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
        // Present the share sheet immediately and dismiss when done
        Color.clear
            .onAppear {
                presentShare()
            }
            .accessibilityHidden(true)
    }
    
    private func presentShare() {
        let controller = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
        controller.completionWithItemsHandler = { _, _, _, _ in
            dismiss()
        }
        
        // Find a presenting view controller
        guard let windowScene = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first,
              let window = windowScene.keyWindow,
              let root = window.rootViewController else {
            dismiss()
            return
        }
        
        // If there's already a presented controller, present from it
        let presenter = root.presentedViewController ?? root
        controller.popoverPresentationController?.sourceView = presenter.view
        controller.popoverPresentationController?.sourceRect = presenter.view.bounds
        presenter.present(controller, animated: true)
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
