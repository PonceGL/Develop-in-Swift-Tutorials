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
                            DocumentPickerView(showFileImporter: $viewModel.showFileImporter, disabled: viewModel.showFileImporter, handleFiles: viewModel.loadFiles)
                        }
                    }
                }
            }
            .navigationTitle("Files")
        } detail: {
            DocumentPickerView(showFileImporter: $viewModel.showFileImporter, disabled: (viewModel.showFileImporter || viewModel.files.count > 0), handleFiles: viewModel.loadFiles)
        }
    }
}

#Preview {
    SelectView()
}
