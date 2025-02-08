//
//  FlickrPhoto.swift
//  CodeChallenge
//
//  Created by Ivan Alejandro Hernandez Sanchez on 07/02/25.
//

import Foundation
import SwiftUI

struct FlickrPhoto: Codable, Identifiable {
    let id = UUID()
    let title: String
    let link: String
    let media: Media
    let dateTaken: String
    let published: String
    let author: String
    let authorID: String
    let description: String
    let tags: String

    enum CodingKeys: String, CodingKey {
        case title, link, media, tags, description
        case dateTaken = "date_taken"
        case published, author
        case authorID = "author_id"
    }
}

// Modelo para la imagen
struct Media: Codable {
    let m: String
}
