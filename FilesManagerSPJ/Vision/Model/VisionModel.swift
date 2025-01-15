//
//  VisionModel.swift
//  FilesManagerSPJ
//
//  Created by Ponciano Guevara Lozano on 14/01/25.
//

import Foundation
import AppKit
import Vision

class VisionModel: ObservableObject {
    @Published var extractedText: String?

    func extractText(from image: NSImage, completion: @escaping (Result<String, Error>) -> Void) {
        
        guard let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil) else {
            completion(.failure(NSError(domain: "VisionDemo", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unable to convert NSImage to CGImage"])))
            return
        }

        let request = VNRecognizeTextRequest { (request, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            var recognizedText = ""
            if let results = request.results as? [VNRecognizedTextObservation] {
                for observation in results {
                    if let topCandidate = observation.topCandidates(1).first {
                        recognizedText += topCandidate.string + "\n"
                    }
                }
            }
            DispatchQueue.main.async {
                self.extractedText = recognizedText
            }
            completion(.success(recognizedText))
        }

        request.recognitionLevel = .accurate
        request.revision = VNRecognizeTextRequestRevision3
        request.usesLanguageCorrection = true
        request.recognitionLanguages = ["es"]

        let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                try requestHandler.perform([request])
            } catch {
                print("Error al ejecutar la solicitud de Vision: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }

}

