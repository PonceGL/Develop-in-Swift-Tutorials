//
//  MovieList.swift
//  Features
//
//  Created by Ponciano Guevara Lozano on 29/12/24.
//

import SwiftUI
import SwiftData

struct MovieList: View {
    @Query(sort: \Movie.title) private var movies: [Movie]
    @Environment(\.modelContext) private var context
    
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(movies) { movie in
                    NavigationLink(movie.title) {
                        MovieDetail(movie: movie)
                    }
                }
            }
            .navigationTitle("Movies")
            .toolbar {
                ToolbarItem {
                    Button("Add movie", systemImage: "plus", action: addMovie)
                }
            }
        } detail: {
            Text("Select a movie")
                .navigationTitle("Movie")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func addMovie() {
        context.insert(Movie(title: "New Movie", releaseDate: .now))
    }
}

#Preview {
    MovieList()
        .modelContainer(SampleData.shared.modelContainer)
}
