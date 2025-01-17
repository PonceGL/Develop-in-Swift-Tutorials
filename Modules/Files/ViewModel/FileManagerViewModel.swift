//
//  FileManagerViewModel.swift
//  Features
//
//  Created by Ponciano Guevara Lozano on 17/01/25.
//

import Foundation

class FileManagerViewModel: ObservableObject {
    @Published var rootNode: FileNode?
    private let fileManager = FileManager.default
    
    func fetchFiles(from directory: URL) -> FileNode? {
        DispatchQueue.global(qos: .background).async {
            let root = self.fetchNodeRecursively(from: directory)
            DispatchQueue.main.async {
                self.rootNode = root
            }
            
        }
        return self.rootNode
    }
    
    private func fetchNodeRecursively(from directory: URL) -> FileNode {
        var children: [FileNode] = []
        
        if let directoryContents = try? fileManager.contentsOfDirectory(at: directory, includingPropertiesForKeys: [.isDirectoryKey], options: [.skipsHiddenFiles]) {
            for url in directoryContents {
//                let isDirectory = (try? url.resourceValues(forKeys: [.isDirectoryKey]).isDirectory) ?? false
                let isDirectory = url.hasDirectoryPath
                if isDirectory {
                    let childNode = fetchNodeRecursively(from: url)
                    children.append(childNode)
                } else {
                    children.append(FileNode(url: url, isDirectory: false))
                }
            }
        }
        
        return FileNode(url: directory, isDirectory: true, children: children.isEmpty ? nil : children)
    }
    
//    func fetchFiles(from directory: URL) {
//        fileItems = []
//        let items = fetchFilesRecursively(from: directory)
//        print("===========================")
//        print("FileManagerViewModel items")
//        print(items)
//        print("===========================")
//        DispatchQueue.main.async {
//            self.fileItems = items
//        }
//    }
//    
//    private func fetchFilesRecursively(from directory: URL) -> [FileItem] {
//        var items: [FileItem] = []
//        
//        guard let directoryContents = try? fileManager.contentsOfDirectory(at: directory, includingPropertiesForKeys: nil, options: .skipsHiddenFiles) else {
//            return items
//        }
//        
//        for url in directoryContents {
//            let isDirectory = url.hasDirectoryPath
//            items.append(FileItem(url: url, isDirectory: isDirectory))
//            
//            if isDirectory {
//                items.append(contentsOf: fetchFilesRecursively(from: url))
//            }
//        }
//        
//        return items
//    }
}
