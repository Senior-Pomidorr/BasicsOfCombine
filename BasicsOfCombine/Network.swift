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
        .shared
        .dataTaskPublisher(for: url)
        .map { $0.data }
        .decode(type: MovieResponse.self, decoder: jsonDecoder)
        .mapError { error in
            print(error.localizedDescription)
            return error
        }
        
}
