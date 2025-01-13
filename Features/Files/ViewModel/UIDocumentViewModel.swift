//
//  UIDocumentViewModel.swift
//  Features
//
//  Created by Ponciano Guevara Lozano on 13/01/25.
//

import Foundation
import UIKit

class UIDocumentViewModel: UIViewController, UIDocumentPickerDelegate {
//    let handleSelectedDirectory: (_ url: URL) -> Void
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
//    init(handleSelectedDirectory: @escaping (_: URL) -> Void) {
//        self.handleSelectedDirectory = handleSelectedDirectory
//    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let directoryURL = urls.first else { return }
        print("======================")
        print("UIDocumentViewModel directoryURL")
        print(directoryURL)
        print("======================")
    }

    func showDocumentPicker() {
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.directory])
        documentPicker.delegate = self
        present(documentPicker, animated: true)
    }
}
