//
//  FileManagerViewModel.swift
//  Features
//
//  Created by Ponciano Guevara Lozano on 13/01/25.
//

import Foundation

// FileManagerViewModel

class FileManagerService {
    static let shared = FileManagerService()
    
    private let fileManager = FileManager.default
    
    func directoryExists(at url: URL) -> Bool {
        return fileManager.fileExists(atPath: url.path)
    }
    
    func filesInDirectory(at url: URL) -> [URL]? {
        do {
            let _ = url.startAccessingSecurityScopedResource()
            let fileURLs = try fileManager.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            defer { url.stopAccessingSecurityScopedResource() } 
            return fileURLs
        } catch let error {
            print("===================")
            print("==== loadDirectory error ====")
            print(error)
            print("===================")
            return nil
        }
    }
}
