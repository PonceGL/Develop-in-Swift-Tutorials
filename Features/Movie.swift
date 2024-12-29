//
//  Movie.swift
//  Features
//
//  Created by Ponciano Guevara Lozano on 29/12/24.
//

import Foundation
import SwiftData

@Model
class Movie {
    var title: String
    var releaseDate: Date
    
    init(title: String, releaseDate: Date) {
        self.title = title
        self.releaseDate = releaseDate
    }
}
