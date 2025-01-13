//
//  DocumentPickerView.swift
//  Features
//
//  Created by Ponciano Guevara Lozano on 12/01/25.
//

import SwiftUI
import UniformTypeIdentifiers

struct DocumentPickerView: View {
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
                    .frame(maxWidth: .infinity)
                    .frame(height: 200)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .onDrop(
                        of: [.pdf],
                        isTargeted: nil,
                        perform: handleDrop
                    )
            }
            
            Button("Add file", systemImage: "plus", action: {
                showFileImporter = true
            })
            .disabled(disabled)
        }
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
    DocumentPickerView(showFileImporter: .constant(false), disabled: false, handleFiles: handleFiles, handleDrop: handleDrop)
}
