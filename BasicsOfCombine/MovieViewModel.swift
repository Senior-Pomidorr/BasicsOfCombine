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
    var caтcellables = Set<AnyCancellable>()
    var movies: [Movie] {
        return moviesUpcoming
    }
    func fetchInitialData() {
        fetchMovies()
            .map(\.results)
            .receive(on: DispatchQueue.main)
            .replaceError(with: [])
            .assign(to: &$moviesUpcoming)
    }
}
