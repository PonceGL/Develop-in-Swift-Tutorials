//
//  SelectView.swift
//  Features
//
//  Created by Ponciano Guevara Lozano on 12/01/25.
//

import SwiftUI

struct SelectView: View {
    @StateObject private var viewModel = FilesViewModel()
//    @State private var showFileImporter = false
    
    var body: some View {
        NavigationSplitView {
            VStack {
                Text("Select Files View!")
                if UIDevice.current.userInterfaceIdiom != .pad {
                    DocumentPickerView(showFileImporter: $viewModel.showFileImporter, handleFiles: viewModel.loadFiles)                    
                }
//                List(viewModel.files, id: \.self) { file in
//                    Text(file)
//                }
            }
        } detail: {
            DocumentPickerView(showFileImporter: $viewModel.showFileImporter, handleFiles: viewModel.loadFiles)
        }
    }
}

#Preview {
    SelectView()
}
