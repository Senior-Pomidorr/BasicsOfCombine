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
        List {
            HStack(alignment: .center) {
                Spacer()
                AsyncImage(url: viewModel.movie.posterUrl) { state in
                    switch state {
                    case .empty:
                        ProgressView()
                            .padding(.horizontal, 10)
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .cornerRadius(8)
                            .padding(.horizontal, 0)
                    case .failure(_):
                        Image(systemName: "wifi.slash")
                            .padding(.horizontal, 10)
                    @unknown default:
                        EmptyView()
                    }
                }
                Spacer()
            }
            
            Section(header: Text("Credits")) {
                ForEach(viewModel.data.credits) { credit in
                    VStack(alignment: .leading) {
                        Text(credit.name)
                            .font(.headline)
                        Text(credit.character)
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
        .listStyle(.plain)
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
