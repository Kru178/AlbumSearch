//
//  Model.swift
//  AlbumSearch
//
//  Created by Sergei Krupenikov on 09.09.2021.
//

import Foundation

struct ResultsList: Decodable {
    var resultCount: Int
    var results: [iTunesEntity]
}

struct iTunesEntity: Decodable {
    var wrapperType: String
    var collectionId: Int
    var artistName: String
    var collectionName: String
    var releaseDate: String
    var artworkUrl100: String
    var trackName: String?
    var primaryGenreName: String
    var trackTimeMillis: Int?
}
