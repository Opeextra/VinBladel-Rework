import SwiftUI
import UIKit


public struct PDFGenerator {
    /// Generates a PDF file from the given SwiftUI view.
    /// - Parameter content: The SwiftUI view to render as PDF.
    /// - Returns: The file URL of the generated PDF in the temporary directory, or nil if generation failed.
    public static func generate<Content: View>(from content: Content) -> URL? {
        let hostingController = UIHostingController(rootView: content)
        
        // Set the size to A4 at 72 DPI (595 x 842 points)
        let a4Size = CGSize(width: 595, height: 842)
        hostingController.view.bounds = CGRect(origin: .zero, size: a4Size)
        hostingController.view.backgroundColor = .clear
        
        // Render the view hierarchy so the view has layout info
        let window = UIWindow(frame: hostingController.view.bounds)
        window.rootViewController = hostingController
        window.makeKeyAndVisible()
        hostingController.view.setNeedsLayout()
        hostingController.view.layoutIfNeeded()
        
        let pdfRenderer = UIGraphicsPDFRenderer(bounds: hostingController.view.bounds)
        
        let pdfData = pdfRenderer.pdfData { context in
            context.beginPage()
            hostingController.view.layer.render(in: context.cgContext)
        }
        
        let tempDirectory = FileManager.default.temporaryDirectory
        let filename = UUID().uuidString + ".pdf"
        let fileURL = tempDirectory.appendingPathComponent(filename)
        
        do {
            try pdfData.write(to: fileURL)
            return fileURL
        } catch {
            return nil
        }
    }
}

