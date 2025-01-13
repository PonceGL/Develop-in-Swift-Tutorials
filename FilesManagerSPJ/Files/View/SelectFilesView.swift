//
//  SelectFilesView.swift
//  FilesManagerSPJ
//
//  Created by Ponciano Guevara Lozano on 13/01/25.
//

import SwiftUI

struct SelectFilesView: View {
    @StateObject private var viewModel = SelectFilesViewModel()
    var body: some View {
        NavigationSplitView {
            Group {
                if viewModel.files.count > 0 {
                    List(viewModel.files, id: \.absoluteString) { file in
                        NavigationLink(file.lastPathComponent.replacingOccurrences(of: ".\(file.pathExtension)", with: "")) {
                            PDFViewer(fileURL: file)
                                .tag(file.absoluteString)
//                            Text(file.lastPathComponent)
                        }
                    }
                    .listStyle(.plain)
                } else {
                    VStack (spacing: 20) {
                        Text("Select Files!")
//                        DocumentPickerSectionView(showFileImporter: $viewModel.showFileImporter, disabled: (viewModel.showFileImporter || viewModel.files.count > 0), handleFiles: viewModel.loadFiles, handleDrop: viewModel.handleDrop)
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
            VStack (spacing: 20) {
                DocumentPickerSectionView(showFileImporter: $viewModel.showFileImporter, disabled: (viewModel.showFileImporter || viewModel.files.count > 0), handleFiles: viewModel.loadFiles, handleDrop: viewModel.handleDrop)
            }
        }
    }
}

#Preview {
    SelectFilesView()
}
