//
//  ContentView.swift
//  BasicsOfCombine
//
//  Created by Daniil Kulikovskiy on 12/21/23.
//

import SwiftUI

struct MoviesView: View {
    @StateObject var viewModel = MovieViewModel()
    var body: some View {
        List(viewModel.movies) { movie in
            NavigationLink {
                MovieDetailsView(movie: movie)
            } label: {
                HStack {
                    AsyncImage(url: movie.posterUrl) { state in
                        switch state {
                        case .empty:
                            ProgressView()
                                .frame(width: 100)
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100)
                                .cornerRadius(8)
                        case .failure(_):
                            Image(systemName: "wifi.slash")
                                .frame(width: 100)
                        @unknown default:
                            EmptyView()
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Text(movie.title)
                            .font(.headline)
                        Text(movie.overview)
//                            .font(.caption)
                            .font(.system(size: 14))
                            .lineLimit(3)
                    }
                }
            }
        }
        .searchable(text: $viewModel.searchQuery)
        .onAppear() {
            viewModel.fetchInitialData()
        }
        
        
    }
}

#Preview {
    MoviesView()
}
