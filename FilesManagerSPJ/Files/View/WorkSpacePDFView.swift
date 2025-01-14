//
//  WorkSpacePDFView.swift
//  FilesManagerSPJ
//
//  Created by Ponciano Guevara Lozano on 13/01/25.
//

import SwiftUI

struct WorkSpacePDFView: View {
    var fileURL: URL
    var fileName: String {
        return fileURL.lastPathComponent.replacingOccurrences(of: ".\(fileURL.pathExtension)", with: "")
    }
    
    var body: some View {
        VStack {
            Text("Work Space PDF View!")
            PDFViewer(fileURL: fileURL)
        }
        .navigationTitle(fileName)
    }
}

#Preview {
    WorkSpacePDFView(fileURL: URL(string: "file:///Users/ponciano.guevara@digitalfemsa.com/Downloads/pdf-examples/Avengers_%20Endgame%20(2019)%20-%20IMDb.pdf")!)
}
