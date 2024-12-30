//
//  Friend.swift
//  Features
//
//  Created by Ponciano Guevara Lozano on 29/12/24.
//

import Foundation
import SwiftData


@Model
class Friend {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    static let sampleData = [
        Friend(name: "Elena"),
        Friend(name: "Graham"),
        Friend(name: "Mayuri"),
        Friend(name: "Rich"),
        Friend(name: "Rody"),
    ]
}
