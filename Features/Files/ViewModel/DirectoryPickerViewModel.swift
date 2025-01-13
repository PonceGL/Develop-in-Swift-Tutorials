//
//  DirectoryPickerViewModel.swift
//  Features
//
//  Created by Ponciano Guevara Lozano on 13/01/25.
//

import Foundation
import SwiftUI
import UIKit

class DirectoryPickerViewModel: NSObject, ObservableObject  {
    @Published var selectedDirectory: URL? = nil
    @Published var files: [String] = []
    @Published var errorMessage: String? = nil
    private var viewModelDirectory = DirectoryPickerViewModel()
    
    private let fileManagerService = FileManagerService.shared
    
    func pickDirectory() {
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.folder], asCopy: false)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {
            rootViewController.present(documentPicker, animated: true)
        }
    }
    
    func loadFilesFromSelectedDirectory() {
        guard let directoryURL = selectedDirectory else { return }
        print("===================")
        print("==== loadDirectory directoryURL ====")
        print(directoryURL)
        print("===================")
        
        let directoryExists = fileManagerService.directoryExists(at: directoryURL)
        print("===================")
        print("==== loadDirectory directoryExists ====")
        print(directoryExists)
        print("===================")
        if directoryExists {
            if let filesURLs = fileManagerService.filesInDirectory(at: directoryURL) {
                for item in filesURLs {
                    print("===================")
                    print("==== loadDirectory item ====")
                    print(item)
                    print("===================")
                }
                files = filesURLs.map { $0.lastPathComponent }
                print("===================")
                print("==== loadDirectory files map ====")
                print(files)
                print("===================")
                errorMessage = nil
            } else {
                errorMessage = "No se pudieron cargar los archivos del directorio."
            }
        } else {
            errorMessage = "El directorio ya no existe. Por favor selecciona otro."
        }
    }
}

extension DirectoryPickerViewModel: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        if let directoryURL = urls.first {
            selectedDirectory = directoryURL
            loadFilesFromSelectedDirectory()
        }
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("Picker cancelado")
    }
}
