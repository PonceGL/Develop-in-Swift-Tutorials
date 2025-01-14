//
//  WorkSpacePDFView.swift
//  Features
//
//  Created by Ponciano Guevara Lozano on 13/01/25.
//

import SwiftUI

struct WorkSpacePDFView: View {
    @StateObject private var visionModel = VisionModel()
    private let pDFToImageModel = PDFToImageModel()
    var fileURL: URL
    var fileName: String {
        return fileURL.lastPathComponent.replacingOccurrences(of: ".\(fileURL.pathExtension)", with: "")
    }
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                if UIDevice.current.userInterfaceIdiom != .pad {
                    if visionModel.extractedText != nil {
                        ScrollView {
                            Text(visionModel.extractedText ?? "")
                                .padding()
                                .frame(maxWidth: .infinity)
                        }
                        .frame(maxWidth: .infinity, maxHeight: (proxy.size.height / 2))
                    }
                    
                    PDFViewer(fileURL: fileURL)
                }
                else {
                    HStack {
                        if visionModel.extractedText != nil {
                            ScrollView {
                                Text(visionModel.extractedText ?? "")
                                    .padding()
                                    .frame(maxWidth: .infinity)
                            }
                            .frame(maxWidth: (proxy.size.width / 2))
                        }
                        
                        PDFViewer(fileURL: fileURL)
                    }
                }
            }
            .padding(20)
        }
        .frame(maxWidth: .infinity)
        .shadow(radius: 5)
        .background(Color.blue.opacity(0.1))
        .navigationTitle(fileName)
        .toolbar {
            ToolbarItem {
                Button("Extraer texto", systemImage: "text.viewfinder", action: {
                    let images = pDFToImageModel.convertPDFToImages(pdfUrl: fileURL)
                    visionModel.extractText(from: images)
                })
            }
        }
    }
}

#Preview {
    WorkSpacePDFView(fileURL: URL(string: "file:///Users/ponciano.guevara@digitalfemsa.com/Library/Developer/CoreSimulator/Devices/C551D843-A39D-4835-A205-0760D8B1E45B/data/Containers/Shared/AppGroup/F6EA0570-0015-4EEF-9FD1-72AD2B22A3E0/File%20Provider%20Storage/Creating%20a%20macOS%20app%20%E2%80%94%20SwiftUI%20Tutorials%20_%20Apple%20Developer%20Documentation.pdf")!)
}
