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
    private var network = Network()
    
    private var cancellable = Set<AnyCancellable>()
    @Published var data: (credits: [MovieCastMember], reviews: [MovieReviews]) = ([], [])
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    deinit {
        print("The class MovieDetailViewModel was deinit ")
    }
    
    func fetchData() {
        let creditsPablisher = network.fetchCredits(for: movie)
            .map((\.cast))
            .replaceError(with: [])
        let reviewsPablisher = network.fetchReviews(for: movie)
            .map(\.results)
            .replaceError(with: [])
        
        Publishers.Zip3(creditsPablisher, reviewsPablisher, imagesPublisher)
            .receive(on: DispatchQueue.main)
            .map {(credits: $0.0, reviews: $0.1, images: $0.2)}
            .assign(to: &$data)
    }
}
