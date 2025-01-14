//
//  VisionModel.swift
//  FilesManagerSPJ
//
//  Created by Ponciano Guevara Lozano on 13/01/25.
//

import PDFKit
import Vision

class VisionModel: ObservableObject {
    @Published var extractedText: String?
    
    func extractText(from images: [UIImage]) {
        var fullText = ""

        let group = DispatchGroup()
        
        for image in images {
            guard let cgImage = image.cgImage else { continue }
            group.enter()

            let request = VNRecognizeTextRequest { request, error in
                defer { group.leave() }

                if let error = error {
                    print("Error al reconocer texto: \(error.localizedDescription)")
                    return
                }
                
                guard let observations = request.results as? [VNRecognizedTextObservation] else { return }

                let pageText = observations
                    .compactMap { $0.topCandidates(1).first?.string }
                    .joined(separator: "\n")

                fullText += pageText + "\n\n"
            }

            request.recognitionLevel = .accurate
            request.usesLanguageCorrection = true
            request.recognitionLanguages = ["es"]
            request.revision = VNRecognizeTextRequestRevision3

            let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])

            DispatchQueue.global(qos: .userInitiated).async {
                do {
                    try handler.perform([request])
                } catch {
                    print("Error al ejecutar la solicitud de Vision: \(error.localizedDescription)")
                    group.leave()
                }
            }
        }

        group.notify(queue: .main) {
            self.extractedText = fullText
        }
    }
}
