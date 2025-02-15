//
//  PDFViewer.swift
//  Features
//
//  Created by Ponciano Guevara Lozano on 12/01/25.
//

import SwiftUI
import PDFKit

struct PDFKitView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.autoScales = true
        pdfView.displayMode = .singlePageContinuous
        pdfView.displayDirection = .vertical
        pdfView.backgroundColor = .systemGray6
        
        if let document = PDFDocument(url: url) {
            pdfView.document = document
        }
        
        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: Context) {
        uiView.document = PDFDocument(url: url)
    }
}

struct PDFViewer: View {
    var fileURL: URL
    
    var fileName: String {
        return fileURL.lastPathComponent.replacingOccurrences(of: ".\(fileURL.pathExtension)", with: "")
    }
    
    
    var body: some View {
        VStack{
            PDFKitView(url: fileURL)
        }
        .navigationTitle(fileName)
        .navigationBarTitleDisplayMode( UIDevice.current.userInterfaceIdiom == .pad ? .large : .inline)
    }
}

#Preview {
    PDFViewer(fileURL: URL(string: "file:///Users/ponciano.guevara@digitalfemsa.com/Library/Developer/CoreSimulator/Devices/761AA78C-7169-46B1-BCF3-CAE3FDBDFCD8/data/Containers/Shared/AppGroup/A58E6035-9727-4287-B1F6-06B40EF0FF4D/File%20Provider%20Storage/IMDB/Avengers_%20Endgame%20(2019)%20-%20IMDb.pdf")!)
}
