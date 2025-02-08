//
//  FlickrViewModel.swift
//  CodeChallenge
//
//  Created by Ivan Alejandro Hernandez Sanchez on 07/02/25.
//

import SwiftUI
import Combine

class FlickrViewModel: ObservableObject {
    @Published var photos: [FlickrPhoto] = []
    @Published var isLoading = false
    private var cancellables = Set<AnyCancellable>()

    func fetchPhotos(for tags: String) {
        guard !tags.isEmpty else {
            self.photos = []
            return
        }

        let urlString = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags=\(tags)"
        guard let url = URL(string: urlString) else { return }

        isLoading = true
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: FlickrResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in self.isLoading = false },
                  receiveValue: { self.photos = $0.items })
            .store(in: &cancellables)
    }
}

struct FlickrResponse: Codable {
    let items: [FlickrPhoto]
}
