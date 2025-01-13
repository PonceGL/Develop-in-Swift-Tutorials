//
//  ContentView.swift
//  FilesManagerSPJ
//
//  Created by Ponciano Guevara Lozano on 13/01/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = SelectFilesViewModel()
    var body: some View {
        SelectFilesView()
            .frame(minWidth: 900, minHeight: 500)
    }
}

#Preview {
    ContentView()
}
