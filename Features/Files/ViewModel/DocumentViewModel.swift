//
//  FilesViewModel.swift
//  Features
//
//  Created by Ponciano Guevara Lozano on 12/01/25.
//

import Foundation
import SwiftUI

class FilesViewModel: ObservableObject {
    @Published var files: [URL] = []
    @Published var showFileImporter = false
    
    
    func loadFiles(result: Result<[URL], any Error>) {
        switch result {
            case .success(let files):
                files.forEach { file in
                    let gotAccess = file.startAccessingSecurityScopedResource()
                    if !gotAccess { return }
                    self.files.append(file)
//                    file.stopAccessingSecurityScopedResource() // TODO
                }
            case .failure(let error):
                print("======================")
                print("=== loadFiles error ===")
                print(error)
                print("======================")
        }
    }
    
    
}
