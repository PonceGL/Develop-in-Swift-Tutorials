//
//  WorkSpacePDFView.swift
//  FilesManagerSPJ
//
//  Created by Ponciano Guevara Lozano on 13/01/25.
//

import SwiftUI
import AppKit

struct WorkSpacePDFView: View {
    @State var isLoading: Bool = false
    private let pdfToImageModel = PDFToImageModel()
    @State var image: NSImage?
    var fileURL: URL
    var fileName: String {
        return fileURL.lastPathComponent.replacingOccurrences(of: ".\(fileURL.pathExtension)", with: "")
    }
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                VStack {
                    HStack {
                        if image != nil {
                            Image(nsImage: image!)
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: (proxy.size.width / 2))
                                .onAppear {
                                    isLoading = false
                                }
                        } else {
                            Text("Work Space PDF View!")
                        }
                        PDFViewer(fileURL: fileURL)
                            .opacity(isLoading ? 0.2 : 1)
                    }
                }
                
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        .scaleEffect(1)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .shadow(radius: 5)
        .background(Color.blue.opacity(0.1))
        .navigationTitle(fileName)
        .toolbar{
            ToolbarItem {
                Button("Extraer texto", systemImage: "text.viewfinder", action: {
                    isLoading = true
                    let images = pdfToImageModel.convertPDFToImages(pdfURL: fileURL)
                    if images.count > 0 {
                        self.image = images.first
                    }
//                    visionModel.extractText(from: images)
                })
                .disabled(isLoading)
            }
        }
    }
}

#Preview {
    WorkSpacePDFView(fileURL: URL(string: "file:///Users/ponciano.guevara@digitalfemsa.com/Downloads/pdf-examples/Avengers_%20Endgame%20(2019)%20-%20IMDb.pdf")!)
}
