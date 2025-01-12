//
//  FilesModel.swift
//  Features
//
//  Created by Ponciano Guevara Lozano on 12/01/25.
//

import Foundation

struct DocumentModel: Identifiable {
    let id = UUID()
    let url: URL
    let name: String
}

