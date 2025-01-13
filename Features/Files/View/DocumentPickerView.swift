//
//  DocumentPickerView.swift
//  Features
//
//  Created by Ponciano Guevara Lozano on 12/01/25.
//

import SwiftUI

struct DocumentPickerView: View {
    @Binding var showFileImporter: Bool
    var disabled: Bool = false
    let handleFiles: (_ result: Result<[URL], any Error>) -> Void
    
    var body: some View {
        Button("Add file", systemImage: "plus", action: {
            showFileImporter = true
        })
        .disabled(disabled)
        .fileImporter(isPresented: $showFileImporter, allowedContentTypes: [.pdf, .folder], allowsMultipleSelection: true, onCompletion: handleFiles)
    }
}

#Preview {
    DocumentPickerView(showFileImporter: .constant(false), disabled: false) { result in
        print(result)
    }
}
