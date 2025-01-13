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
    @Published var showFileImporter = false
    @Published var errorMessage: String? = nil
    private var selectedDirectory: URL? = nil
    private var fileSet: Set<String> = []
    private let fileManagerService = FileManagerService.shared
    
    private func addFile(file: URL) {
        let gotAccess = file.startAccessingSecurityScopedResource()
        if gotAccess {
            if file.hasDirectoryPath { return } // TODO: handle sub directories
            if file.pathExtension != "pdf" { return }
            
            let fileKey = file.absoluteString
            guard !fileSet.contains(fileKey) else { return }
            
            fileSet.insert(file.absoluteString)
            defer { file.stopAccessingSecurityScopedResource() }
            DispatchQueue.main.async {
                self.files.append(file)
            }
        }
    }
    
    private func addFilesFromDirectory(directory: URL) {
        selectedDirectory = directory
        let files = loadFilesFromSelectedDirectory()
        for file in files {
            file.stopAccessingSecurityScopedResource()
            addFile(file: file)
        }
    }
    
    private  func loadFilesFromSelectedDirectory() -> [URL] {
        guard let directoryURL = selectedDirectory else { return [] }
        
        let directoryExists = fileManagerService.directoryExists(at: directoryURL)
        if directoryExists {
            if let filesURLs = fileManagerService.filesInDirectory(at: directoryURL) {
                errorMessage = nil
                return filesURLs
            } else {
                errorMessage = "No se pudieron cargar los archivos del directorio."
                return []
            }
        } else {
            errorMessage = "El directorio ya no existe. Por favor selecciona otro."
            return []
        }
    }
    
    func loadFiles(result: Result<[URL], any Error>) {
        switch result {
            case .success(let files):
            for file in files {
                if file.hasDirectoryPath {
                    addFilesFromDirectory(directory: file)
                } else {
                    addFile(file: file)
                }
            }
            
            case .failure(let error):
                print("======================")
                print("=== loadFiles error ===")
                print(error)
                print("======================")
            errorMessage = error.localizedDescription
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
                        self.errorMessage = error.localizedDescription
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
