//
//  FilesViewModel.swift
//  Features
//
//  Created by Ponciano Guevara Lozano on 12/01/25.
//

import Foundation
import SwiftUI
import UniformTypeIdentifiers

class FilesViewModel: ObservableObject {
    @Published var files: [URL] = []
    private var fileSet: Set<String> = []
    @Published var showFileImporter = false
    
    private func addFiles(_ newFiles: [URL]) {
        for file in newFiles {
            let fileKey = file.absoluteString
            guard !fileSet.contains(fileKey) else { continue }
            
            let gotAccess = file.startAccessingSecurityScopedResource()
            if gotAccess {
                fileSet.insert(file.absoluteString)
                DispatchQueue.main.async {
                    self.files.append(file)
                }
            }
            
        }
    }
    
    func loadFiles(result: Result<[URL], any Error>) {
        switch result {
            case .success(let files):
            addFiles(files)
            case .failure(let error):
                print("======================")
                print("=== loadFiles error ===")
                print(error)
                print("======================")
        }
    }
    
    func handleDrop(providers: [NSItemProvider]) -> Bool {
            var handled = false
            
            for provider in providers {
                if provider.hasItemConformingToTypeIdentifier(UTType.pdf.identifier) {
                    provider.loadItem(forTypeIdentifier: UTType.pdf.identifier, options: nil) { item, error in
                        if let error = error {
                            print("======================")
                            print("=== handleDrop error ===")
                            print(error)
                            print("======================")
                        }
                        
                        if let item = item {
                            DispatchQueue.main.async {
                                self.files.append(URL(string: String(describing: item))!)
                                handled = true
                            }
                        }
                    }
                } else {
                    print("=== ELSE ===")
                }
            }
            
            return handled
        }
    
    
}
