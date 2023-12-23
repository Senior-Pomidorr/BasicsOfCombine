//
//  Network.swift
//  BasicsOfCombine
//
//  Created by Daniil Kulikovskiy on 12/21/23.
//

import Foundation
import Combine

func fetchMovies() -> some Publisher<MovieResponse, Error> {
    let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=\(apiKey)")!
    return URLSession
        .shared.dataTaskPublisher(for: url)
        .map { $0.data }
        .decode(type: MovieResponse.self, decoder: jsonDecoder)
        .mapError { error in
            print(error.localizedDescription)
            return error
        }
        
}

func searchMovies(for query: String) -> some Publisher<MovieResponse, Error> {
    let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    print(encodedQuery ?? "failed encoded query")
    let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&query=\(encodedQuery!)")!
    return URLSession
        .shared.dataTaskPublisher(for: url)
        .map(\.data)
        .decode(type: MovieResponse.self, decoder: jsonDecoder)
}

func fetchCredits(for movie: Movie) -> some Publisher<MovieCreditResponse, Error> {
    guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movie.id)/credits?api_key=\(apiKey)") else { return Fail(error: NetworkingError.invalidURL).eraseToAnyPublisher() }
    return URLSession
        .shared.dataTaskPublisher(for: url)
        .map(\.data)
        .decode(type: MovieCreditResponse.self, decoder: jsonDecoder)
        .eraseToAnyPublisher()
}

func fetchReviews(for movie: Movie) -> some Publisher<MovieReviewsResponse, Error> {
    guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movie.id)/reviews?api_key=\(apiKey)") else { return Fail(error: NetworkingError.invalidURL).eraseToAnyPublisher() }
    return URLSession
        .shared.dataTaskPublisher(for: url)
        .map(\.data)
        .decode(type: MovieReviewsResponse.self, decoder: jsonDecoder)
        .eraseToAnyPublisher()
}

enum NetworkingError: Error {
    case invalidURL
}
