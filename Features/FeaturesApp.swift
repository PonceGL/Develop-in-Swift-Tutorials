//
//  FeaturesApp.swift
//  Features
//
//  Created by Ponciano Guevara Lozano on 29/12/24.
//

import SwiftUI
import SwiftData

@main
struct FeaturesApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(SampleData.shared.modelContainer)
    }
}
