//
//  SelectView.swift
//  Features
//
//  Created by Ponciano Guevara Lozano on 12/01/25.
//

import SwiftUI

struct SelectView: View {
    @StateObject private var viewModel = SelectFilesViewModel()
    @State private var selectedFile: URL?
    
    var body: some View {
        NavigationSplitView {
            Group {
                if viewModel.files.count > 0 {
                    List(viewModel.files, id: \.lastPathComponent, selection: $selectedFile) { file in
                        NavigationLink(file.lastPathComponent.replacingOccurrences(of: ".\(file.pathExtension)", with: "")) {
                            WorkSpacePDFView(fileURL: file)
                        }
                    }
                    .listStyle(.plain)
                } else {
                    VStack (spacing: 20) {
                        Text("Select Files View!")
                        if UIDevice.current.userInterfaceIdiom != .pad {
                            DocumentPickerView(showFileImporter: $viewModel.showFileImporter, disabled: (viewModel.showFileImporter || viewModel.files.count > 0), handleFiles: viewModel.loadFiles, handleDrop: viewModel.handleDrop)
                        }
                    }
                }
            }
            .navigationTitle("Files")
            .toolbar {
                ToolbarItem {
                    Button("Add files", systemImage: "plus", action: {
                        viewModel.showFileImporter = true
                    })
                    .disabled(viewModel.showFileImporter)
                }
            }
            .fileImporter(isPresented: $viewModel.showFileImporter, allowedContentTypes: [.pdf, .folder], allowsMultipleSelection: true, onCompletion: viewModel.loadFiles)
        } detail: {
            if let selectedFile = selectedFile {
                PDFViewer(fileURL: selectedFile)
            } else {
                VStack (spacing: 20) {
                    Text("Select Files View!")
                    DocumentPickerView(showFileImporter: $viewModel.showFileImporter, disabled: (viewModel.showFileImporter || viewModel.files.count > 0), handleFiles: viewModel.loadFiles, handleDrop: viewModel.handleDrop)
                }
            }
        }
    }
}

#Preview {
    SelectView()
}
