//
//  PDFToImageModel.swift
//  FilesManagerSPJ
//
//  Created by Ponciano Guevara Lozano on 13/01/25.
//

import PDFKit


class PDFToImageModel {
    
    func convertPDFToImages(pdfUrl: URL) -> [UIImage] {
        guard let pdfDocument = PDFDocument(url: pdfUrl) else {
            print("Unable to open PDF document.")
            return []
        }
        
        var images = [UIImage]()
        
        for pageIndex in 0..<pdfDocument.pageCount {
            guard let page = pdfDocument.page(at: pageIndex) else { continue }
            let pageBounds = page.bounds(for: .mediaBox)

            let renderer = UIGraphicsImageRenderer(size: pageBounds.size)
            let image = renderer.image { context in
                let cgContext = context.cgContext
                
                cgContext.translateBy(x: 0, y: pageBounds.size.height)
                cgContext.scaleBy(x: 1.0, y: -1.0)
                
                page.draw(with: .mediaBox, to: cgContext)
            }
            images.append(image)
        }
        
        return images
    }
}
