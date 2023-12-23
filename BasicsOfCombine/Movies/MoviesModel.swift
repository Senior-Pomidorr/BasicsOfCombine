//
//  Code.swift
//  BasicsOfCombine
//
//  Created by Daniil Kulikovskiy on 12/21/23.
//

import Foundation

let jsonDecoder: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return decoder
}()

let apiKey = "e8b7e7865472b86ec7f5c61aab670dfd"

struct Movie: Decodable, Equatable, Identifiable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    var posterUrl: URL? {
        posterPath.map { URL(string: "https://image.tmdb.org/t/p/w400/\($0)")! }
    }
}

struct MovieResponse: Decodable {
    let results: [Movie]
}

struct MovieCastMember: Identifiable, Equatable, Decodable {
    let id: Int
    let name: String
    let character: String
}

struct MovieCreditResponse: Decodable {
    let cast: [MovieCastMember]
}

struct MovieReviews: Identifiable, Equatable, Decodable {
    let id: String
    let author: String
    let content: String
}

struct MovieReviewsResponse: Decodable {
    let results: [MovieReviews]
}
