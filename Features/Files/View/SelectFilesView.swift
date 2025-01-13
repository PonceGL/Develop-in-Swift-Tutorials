//
//  SelectView.swift
//  Features
//
//  Created by Ponciano Guevara Lozano on 12/01/25.
//

import SwiftUI

struct SelectView: View {
    @StateObject private var viewModel = FilesViewModel()
    
    var body: some View {
        NavigationSplitView {
            Group {
                if viewModel.files.count > 0 {
                    List {
                        ForEach(viewModel.files, id: \.absoluteString) { file in
                            NavigationLink(file.lastPathComponent.replacingOccurrences(of: ".\(file.pathExtension)", with: "")) {
                                PDFViewer(fileURL: file)
                            }
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
                    Button("Add movie", systemImage: "plus", action: {
                        viewModel.showFileImporter = true
                    })
                    .disabled(viewModel.showFileImporter)
                }
            }
            .fileImporter(isPresented: $viewModel.showFileImporter, allowedContentTypes: [.pdf, .folder], allowsMultipleSelection: true, onCompletion: viewModel.loadFiles)
        } detail: {
            DocumentPickerView(showFileImporter: $viewModel.showFileImporter, disabled: (viewModel.showFileImporter || viewModel.files.count > 0), handleFiles: viewModel.loadFiles, handleDrop: viewModel.handleDrop)
        }
    }
}

#Preview {
    SelectView()
}
