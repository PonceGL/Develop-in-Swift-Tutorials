//
//  DocumentPickerSectionView.swift
//  FilesManagerSPJ
//
//  Created by Ponciano Guevara Lozano on 13/01/25.
//

import SwiftUI

struct DocumentPickerSectionView: View {
    @Binding var showFileImporter: Bool
    var disabled: Bool = false
    let handleFiles: (_ result: Result<[URL], any Error>) -> Void
    let handleDrop: (_ providers: [NSItemProvider]) -> Bool
    
    var body: some View {
        VStack(spacing: 40) {
            if !disabled {
                Text("Drag & Drop Files Here")
                    .font(.title2)
                    .padding()
//                    .frame(maxWidth: .infinity)
//                    .frame(height: 200)
//                    .background(Color.gray.opacity(0.2))
//                    .cornerRadius(10)
//                    .onDrop(
//                        of: [.pdf],
//                        isTargeted: nil,
//                        perform: handleDrop
//                    )
            }
            
            Button("Add file", systemImage: "plus", action: {
                showFileImporter = true
            })
            .disabled(disabled)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.blue.opacity(0.2))
        .onDrop(
            of: [.pdf],
            isTargeted: nil,
            perform: handleDrop
        )
    }
}

func handleFiles(result: Result<[URL], any Error>) {
    print(result)
}
func handleDrop(providers: [NSItemProvider]) -> Bool {
    print(providers)
    return true
}

#Preview {
    DocumentPickerSectionView(showFileImporter: .constant(false), disabled: false, handleFiles: handleFiles, handleDrop: handleDrop)
}
