//
//  FileModel.swift
//  Features
//
//  Created by Ponciano Guevara Lozano on 17/01/25.
//

import Foundation

struct FileItem: Identifiable, Equatable {
    let id = UUID()
    let url: URL
    let isDirectory: Bool
}

struct FileNode: Identifiable {
    let id = UUID()
    let url: URL
    let isDirectory: Bool
    var children: [FileNode]?
}
