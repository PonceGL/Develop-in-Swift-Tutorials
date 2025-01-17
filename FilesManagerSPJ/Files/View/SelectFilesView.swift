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
//                if viewModel.files.count > 0 {
//                    List(viewModel.files, id: \.absoluteString) { file in
//                        NavigationLink(file.lastPathComponent.replacingOccurrences(of: ".\(file.pathExtension)", with: "")) {
//                            WorkSpacePDFView(fileURL: file)
//                        }
//                    }
//                    .listStyle(.plain)
//                }
                if let directoryURL = viewModel.selectedDirectory {
                    NavigationLink(directoryURL.lastPathComponent.replacingOccurrences(of: ".\(directoryURL.pathExtension)", with: "")){
                        Text("Directorio: \(String(describing: directoryURL.lastPathComponent))")
                            .font(.headline)
                            .padding()
                    }
                    FileListView(directoryURL: directoryURL)
                        .onAppear{
                            viewModel.showFileImporter = false
                        }
                }
                else {
                    VStack (spacing: 20) {
                        Text("Select Files!")
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
            .fileImporter(isPresented: $viewModel.showFileImporter, allowedContentTypes: [.folder], allowsMultipleSelection: true, onCompletion: viewModel.loadFiles)
//            .fileImporter(isPresented: $viewModel.showFileImporter, allowedContentTypes: [.pdf], allowsMultipleSelection: true, onCompletion: viewModel.loadFiles)
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
