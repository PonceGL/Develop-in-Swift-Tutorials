//
//  ContentView.swift
//  Features
//
//  Created by Ponciano Guevara Lozano on 29/12/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
//        TabView {
//            Tab("Files", systemImage: "folder.fill") {
//                SelectView()
//            }
//            
//            Tab("Friends", systemImage: "person.and.person") {
//                FriendList()
//            }
//
//            Tab("Movies", systemImage: "film.stack") {
//                FilteredMovieList()
//            }
//        }
        SelectView()

    }
}

#Preview {
    ContentView()
        .modelContainer(SampleData.shared.modelContainer)
}
