//
//  PDFToImageModel.swift
//  FilesManagerSPJ
//
//  Created by Ponciano Guevara Lozano on 14/01/25.
//

//

import Foundation
import PDFKit
import AppKit

class PDFToImageModel {
    
    func convertPDFToImages(pdfURL: URL) -> [NSImage] {
        guard let pdfDocument = PDFDocument(url: pdfURL) else {
            print("No se pudo cargar el documento PDF.")
            return []
        }
        
        var images: [NSImage] = []

        for pageIndex in 0..<pdfDocument.pageCount {
            guard let page = pdfDocument.page(at: pageIndex) else { continue }
            
            let pageRect = page.bounds(for: .mediaBox)
            let rotation = page.rotation
            
            let rotatedSize = rotation % 180 == 0 ? pageRect.size : CGSize(width: pageRect.height, height: pageRect.width)

            let imageSize = CGSize(width: rotatedSize.width, height: rotatedSize.height)
            let image = NSImage(size: imageSize)
            
            image.lockFocus()
            guard let context = NSGraphicsContext.current?.cgContext else {
                print("No se pudo obtener el contexto gráfico.")
                return []
            }

            context.saveGState()
            context.translateBy(x: imageSize.width / 2, y: imageSize.height / 2)
            context.rotate(by: CGFloat(rotation) * CGFloat.pi / 180)
            context.translateBy(x: -pageRect.width / 2, y: -pageRect.height / 2)

            page.draw(with: .mediaBox, to: context)
            context.restoreGState()
            image.unlockFocus()

            images.append(image)
        }
        
        return images
    }
}


//Transformación del Contexto
//En el código para iOS, las siguientes líneas aplicaban una transformación al contexto gráfico:
//
//context.translateBy(x: 0, y: pageBounds.size.height)
//context.scaleBy(x: 1.0, y: -1.0)
//Estas transformaciones se utilizan para ajustar el sistema de coordenadas de CoreGraphics. En un contexto gráfico de macOS/iOS:
//
//El origen (0, 0) está en la esquina inferior izquierda de la pantalla por defecto.
//Sin embargo, los PDFs suelen tener el origen en la esquina superior izquierda.
//La transformación en tu código original cambia el sistema de coordenadas para invertir el eje Y (scaleBy(x: 1.0, y: -1.0)), y desplaza el origen al ajustar translateBy(x: 0, y: pageBounds.size.height).
//
//En el código actualizado, usamos:
//
//context.translateBy(x: imageSize.width / 2, y: imageSize.height / 2)
//context.rotate(by: CGFloat(rotation) * CGFloat.pi / 180)
//context.translateBy(x: -pageRect.width / 2, y: -pageRect.height / 2)
//Esto incluye:
//
//Una traducción para centrar la página en el contexto.
//Una rotación en función de rotation para corregir la orientación de la página.
//Otra traducción para ubicar correctamente la página en el contexto después de la rotación.
