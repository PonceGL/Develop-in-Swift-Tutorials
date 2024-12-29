//
//  ContentView.swift
//  Features
//
//  Created by Ponciano Guevara Lozano on 29/12/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Friends", systemImage: "person.and.person") {
                Text("Friends")
            }
            
            Tab("Movies", systemImage: "film.stack") {
                Text("Movies")
            }
        }
    }
}

#Preview {
    ContentView()
}
