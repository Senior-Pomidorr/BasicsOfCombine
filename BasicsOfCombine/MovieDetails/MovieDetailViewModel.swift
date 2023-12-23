//
//  MovieDetailViewModel.swift
//  BasicsOfCombine
//
//  Created by Daniil Kulikovskiy on 12/22/23.
//

import Foundation
import Combine

class MovieDetailViewModel: ObservableObject {
    let movie: Movie
    
    private var cancellable = Set<AnyCancellable>()
    @Published var data: (credits: [MovieCastMember], reviews: [MovieReviews]) = ([], [])
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    func fetchData() {
        let creditsPablisher = fetchCredits(for: movie).map((\.cast)).replaceError(with: [])
        let reviewsPablisher = fetchReviews(for: movie).map(\.results).replaceError(with: [])
        
        Publishers.Zip(creditsPablisher, reviewsPablisher)
            .receive(on: DispatchQueue.main)
            .map {(credits: $0.0, reviews: $0.1)}
            .assign(to: &$data)
        
    }
}
