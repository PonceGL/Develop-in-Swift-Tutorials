//
//  FileListView.swift
//  Features
//
//  Created by Ponciano Guevara Lozano on 17/01/25.
//

import SwiftUI

struct FileListView: View {
    @StateObject private var viewModel = FileManagerViewModel()
    var directoryURL: URL?
    
    var body: some View {
        VStack {
            if let files = viewModel.rootNode?.children {
                List(files, id: \.id, children: \.children) { file in
                    
                    NavigationLink {
                        if file.isDirectory {
//                            Text(file.url.lastPathComponent)
                            FileListView(directoryURL: file.url)
                        }else {
                            WorkSpacePDFView(fileURL: file.url)
                        }
                    } label: {
                        HStack {
                            Image(systemName: file.isDirectory ? "folder" : "doc")
                                .foregroundColor(file.isDirectory ? .blue : .gray)
                            Text(file.url.lastPathComponent)
                                .multilineTextAlignment(.leading)
                                .lineLimit(1)
                                .truncationMode(.tail)

                        }
                    }
                    
//                    NavigationLink(file.lastPathComponent.replacingOccurrences(of: ".\(file.pathExtension)", with: "")) {
//                        if file.isDirectory {
//                            Text(file.url.lastPathComponent)
//                        }else {
//                            WorkSpacePDFView(fileURL: file)
//                        }
//                    }
               }
                .listStyle(SidebarListStyle())
                .scrollContentBackground(.hidden)
            } else {
                if let directoryURL = directoryURL {
                    Text(directoryURL.lastPathComponent)
                    
                }else {
                    Text("Cargando contenido...")
                        .foregroundColor(.gray)
                }
            }
        }
        .frame(minWidth: 400, minHeight: 600)
        .onAppear {
            if let directoryURL = directoryURL {
                 let _ = viewModel.fetchFiles(from: directoryURL)
            }
        }
    }
}

#Preview {
    FileListView(directoryURL: URL(string: "file:///Users/ponciano.guevara@digitalfemsa.com/Downloads/pdf-examples")!)
}
