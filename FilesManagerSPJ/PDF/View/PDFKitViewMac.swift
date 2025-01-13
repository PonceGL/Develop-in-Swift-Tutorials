//
//  PDFKitViewMac.swift
//  FilesManagerSPJ
//
//  Created by Ponciano Guevara Lozano on 13/01/25.
//

import SwiftUI
import PDFKit

struct PDFKitViewMac: NSViewRepresentable {
    let url: URL

    func makeNSView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.autoScales = true
        pdfView.displayMode = .singlePageContinuous
        pdfView.displayDirection = .vertical
        pdfView.backgroundColor = .lightGray
        
        if let document = PDFDocument(url: url) {
            print("document: \(document)")
            pdfView.document = document
        }
        
        return pdfView
    }

    func updateNSView(_ nsView: PDFView, context: Context) {
        nsView.document = PDFDocument(url: url)
    }
}

struct PDFViewer: View {
    var fileURL: URL
    
    var fileName: String {
        return fileURL.lastPathComponent.replacingOccurrences(of: ".\(fileURL.pathExtension)", with: "")
    }
    
    
    var body: some View {
        
        VStack{
            PDFKitViewMac(url: fileURL)
        }
        .navigationTitle(fileName)
    }
}

#Preview {
    PDFViewer(fileURL: URL(string: "file:///Users/ponciano.guevara@digitalfemsa.com/Downloads/pdf-examples/Avengers_%20Endgame%20(2019)%20-%20IMDb.pdf")!)
}
