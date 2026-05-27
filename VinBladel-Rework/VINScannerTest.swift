//
//  VINScannerTest.swift
//  VinBladel-Rework
//
//  Created by Jacob M. Caulfield on 12/15/25.
//
import SwiftUI
import VisionKit
import Vision

struct AddVINView: View{
    @Binding var scannedVIN: String?
    @State var tempScannedVIN: String? = nil
    @State var showScanner: Bool = false
    @State var scannerAvailable: Bool = DataScannerViewController.isSupported && DataScannerViewController.isAvailable
    // if device can use camera, it will add true to the var, otherwise false
    @State var list: [String] = []
    var body: some View{
        VStack {
            if let vin = scannedVIN {
                Text("Scanned VIN: \(vin)")
                    .font(.title)
                    .padding()
                
            } else {
                Text("Tap to Scan VIN")
                    .font(.title)
                    .padding()
            }
            
            Button("Scan VIN") {
                showScanner = true
                if !scannerAvailable {
                    scannedVIN = "Video Access Blocked"
                }
            }
            .disabled(!scannerAvailable)
            //will be disabled if scannerAvailable is false (! means not in this context)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .sheet(isPresented: $showScanner) {
            VINScannerView(scannedVIN: $scannedVIN)
        }
        // adds an overlay to the screen when the button is pressed
        List {
            ForEach(list, id: \.self) { item in
                Text(item)
            }
        }
    }
}
struct VINScannerView: UIViewControllerRepresentable {
    @Binding var scannedVIN: String?
    
    func makeUIViewController(context: Context) -> DataScannerViewController {
        let scanner = DataScannerViewController(
            recognizedDataTypes: [.barcode(symbologies: [.qr, .code39, .code128, .dataMatrix])],  // types of barcodes used for VINs
            qualityLevel: .accurate,
            recognizesMultipleItems: false,
            isHighFrameRateTrackingEnabled: false,
            isHighlightingEnabled: true
        )
        scanner.delegate = context.coordinator // when scanner is opened, it tells the context
        try? scanner.startScanning()
        return scanner
    }
    func updateUIViewController(_ uiViewController: DataScannerViewController, context: Context) {}
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, DataScannerViewControllerDelegate {
        var parent: VINScannerView // parent struct is VINScannerView
        init(_ parent: VINScannerView) {
            self.parent = parent
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, didTapOn item: RecognizedItem) {
            switch item {
            case .barcode(let barcode):
                if let vin = barcode.payloadStringValue, vin.count == 17 {  // VINs are 17 characters
                    parent.scannedVIN = vin // sets the @Binding var defined at the top to the vin it just unwrapped
                    dataScanner.dismiss(animated: true) // dismisses the view
                }
            default:
                break
            }
        }
    }
}

