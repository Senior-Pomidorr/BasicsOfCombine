//
//  MovieDetailsView.swift
//  BasicsOfCombine
//
//  Created by Daniil Kulikovskiy on 12/23/23.
//

import SwiftUI

struct MovieDetailsView: View {
    
    @StateObject var viewModel: MovieDetailViewModel
    
    init(movie: Movie) {
        _viewModel = StateObject(wrappedValue: MovieDetailViewModel(movie: movie))
    }
    
    var body: some View {
        List{
            Section(header: Text("Credits")) {
                ForEach(viewModel.data.credits) { credit in
                    VStack(alignment: .leading) {
                        Text(credit.name)
                            .font(.headline)
                        Text(credit.charahter)
                            .font(.caption)
                    }
                }
            }
            Section(header: Text("Reviews")) {
                ForEach(viewModel.data.reviews) { review in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(review.author)
                            .font(.headline)
                        Text(review.content)
                            .font(.body)
                    }
                }
            }
        }
        .navigationTitle(viewModel.movie.title)
        .onAppear() {
            viewModel.fetchData()
        }
    }
}

struct MovieDetailsView_Previews: PreviewProvider {
    static let movie = Movie(id: 580489,
                             title: "Venom: Let There Be Carnage",
                             overview: "After finding a host body in investigative reporter Eddie Brock, the alien symbiote must face a new enemy, Carnage, the alter ego of serial killer Cletus Kasady.",
                             posterPath: "/rjkmN1dniUHVYAtwuV3Tji7FsDO.jpg")

    static var previews: some View {
        NavigationView {
            MovieDetailsView(movie: movie)
        }
    }
}
