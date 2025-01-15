//
//  WorkSpacePDFView.swift
//  FilesManagerSPJ
//
//  Created by Ponciano Guevara Lozano on 13/01/25.
//

import SwiftUI
import AppKit

struct WorkSpacePDFView: View {
    @StateObject private var visionModel = VisionModel()
    @State var isLoading: Bool = false
    private let pdfToImageModel = PDFToImageModel()
    var fileURL: URL
    var fileName: String {
        return fileURL.lastPathComponent.replacingOccurrences(of: ".\(fileURL.pathExtension)", with: "")
    }
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                VStack {
                    HStack {
                        if visionModel.extractedText != nil {
                            ScrollView {
                                Text(visionModel.extractedText ?? "")
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .onAppear {
                                        isLoading = false
                                    }
                            }
                            .frame(maxWidth: .infinity, maxHeight: proxy.size.height)
                        }
                        else {
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
                        visionModel.extractText(from: images.first!){ _ in }
                    }
                })
                .disabled(isLoading)
            }
        }
    }
}

#Preview {
    WorkSpacePDFView(fileURL: URL(string: "file:///Users/ponciano.guevara@digitalfemsa.com/Downloads/pdf-examples/Avengers_%20Endgame%20(2019)%20-%20IMDb.pdf")!)
}
