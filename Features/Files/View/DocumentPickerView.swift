//
//  DocumentPickerView.swift
//  Features
//
//  Created by Ponciano Guevara Lozano on 12/01/25.
//

import SwiftUI

struct DocumentPickerView: View {
    @StateObject private var viewModel = FilesViewModel()
    @Binding var showFileImporter: Bool
    let handleFiles: (_ result: Result<[URL], any Error>) -> Void
    
    var body: some View {
        VStack {
            Text("Select a file")
                .navigationTitle("Files")
                .navigationBarTitleDisplayMode(.inline)
            
            Button("Add file", systemImage: "plus", action: {
                print("button")
                viewModel.showFileImporter = true
            })
        }
        .fileImporter(isPresented: $viewModel.showFileImporter, allowedContentTypes: [.pdf, .directory], allowsMultipleSelection: true, onCompletion: viewModel.loadFiles)
    }
}

#Preview {
    DocumentPickerView(showFileImporter: .constant(false)) { result in
        print(result)
    }
}
