//
//  MovieViewModel.swift
//  BasicsOfCombine
//
//  Created by Daniil Kulikovskiy on 12/21/23.
//

import Foundation
import Combine

final class MovieViewModel: ObservableObject {
    @Published var moviesUpcoming: [Movie] = []
    @Published var searchResults: [Movie] = []
    @Published var searchQuery: String = ""
    private var network = Network()
    var caтcellables = Set<AnyCancellable>()
    var movies: [Movie] {
        if searchQuery.isEmpty {
            return moviesUpcoming
        } else {
            return searchResults
        }
    }
    
    init() {
        $searchQuery
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .map { searchQuery in
                self.network.searchMovies(for: searchQuery)
                    .replaceError(with: MovieResponse(results: []))
            }
            .switchToLatest()
            .map(\.results)
            .receive(on: DispatchQueue.main)
            .assign(to: &$searchResults)
    }
    
    func fetchInitialData() {
        network.fetchMovies()
            .map(\.results)
            .receive(on: DispatchQueue.main)
            .replaceError(with: [])
            .assign(to: &$moviesUpcoming)
    }
}
