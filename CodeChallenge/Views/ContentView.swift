//
//  ContentView.swift
//  CodeChallenge
//
//  Created by Ivan Alejandro Hernandez Sanchez on 07/02/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = FlickrViewModel()
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            VStack {
                TextField("Search with Flickr...", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .onChange(of: searchText, { _, newValue in
                        viewModel.fetchPhotos(for: newValue)
                    })

                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .padding()
                }
                if viewModel.photos.count > 0 {
                    ScrollView {
                        LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 3)) {
                            ForEach(viewModel.photos) { photo in
                                NavigationLink(destination: DetailView(photo: photo)) {
                                    AsyncImage(url: URL(string: photo.media.m)) { image in
                                        image.resizable().scaledToFit()
                                    } placeholder: {
                                        Color.gray.frame(height: 100)
                                    }
                                }
                            }
                        }
                        .padding()
                    }
                } else {
                    Text("Please search something")
                    Spacer()
                }
            }
            .navigationTitle("Ivan's code challenge")
        }
    }
}
#Preview {
    ContentView()
}
