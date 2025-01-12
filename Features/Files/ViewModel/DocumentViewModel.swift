//
//  FilesViewModel.swift
//  Features
//
//  Created by Ponciano Guevara Lozano on 12/01/25.
//

import Foundation
import SwiftUI

class FilesViewModel: ObservableObject {
    @Published var files: [String] = []
    @Published var showFileImporter = false
    
    
    func loadFiles(result: Result<[URL], any Error>) {
        switch result {
            case .success(let files):
                files.forEach { file in
                    print("======================")
                    print("=== file.path ===")
                    print(file.path)
                    print("======================")
                    // gain access to the directory
                    let gotAccess = file.startAccessingSecurityScopedResource()
                    print("=== directory gotAccess ===")
                    print(gotAccess)
                    print("======================")
                    if !gotAccess { return }
                    // access the directory URL
                    // (read templates in the directory, make a bookmark, etc.)
//                    files.append(file)
                    // release access
                    file.stopAccessingSecurityScopedResource()
                }
            case .failure(let error):
                print("======================")
                print("=== loadFiles error ===")
                print(error)
                print("======================")
        }
    }
    
    
}
