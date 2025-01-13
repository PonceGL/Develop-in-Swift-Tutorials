//
//  FilesViewModel.swift
//  Features
//
//  Created by Ponciano Guevara Lozano on 12/01/25.
//

import Foundation
import SwiftUI
import UniformTypeIdentifiers

class SelectFilesViewModel: ObservableObject {
    @Published var files: [URL] = []
    private var fileSet: Set<String> = []
    @Published var showFileImporter = false
    
    private func addFiles(_ file: URL) {
        let fileKey = file.absoluteString
        guard !fileSet.contains(fileKey) else { return }
        
        let gotAccess = file.startAccessingSecurityScopedResource()
        if gotAccess {
            fileSet.insert(file.absoluteString)
            DispatchQueue.main.async {
                self.files.append(file)
            }
        }
    }
    
    func loadFiles(result: Result<[URL], any Error>) {
        print("======================")
        print("=== loadFiles result ===")
        print(result)
        print("======================")
        
        // Files
        //        [file:///Users/ponciano.guevara@digitalfemsa.com/Library/Developer/CoreSimulator/Devices/761AA78C-7169-46B1-BCF3-CAE3FDBDFCD8/data/Containers/Shared/AppGroup/A58E6035-9727-4287-B1F6-06B40EF0FF4D/File%20Provider%20Storage/IMDB/Avengers_%20Endgame%20(2019)%20-%20IMDb.pdf])
        
        // Directory
//        [file:///Users/ponciano.guevara@digitalfemsa.com/Library/Developer/CoreSimulator/Devices/761AA78C-7169-46B1-BCF3-CAE3FDBDFCD8/data/Containers/Shared/AppGroup/A58E6035-9727-4287-B1F6-06B40EF0FF4D/File%20Provider%20Storage/IMDB/])
        
        
        switch result {
            case .success(let files):
            for file in files {
                if file.hasDirectoryPath {
                    print("======================")
                    print("=== Selected Directory ===")
                    print(file)
                    print("======================")
                } else {
                    print("======================")
                    print("=== Selected File ===")
                    print(file)
                    print("======================")
                    addFiles(file)
                }
            }
            
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
