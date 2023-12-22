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
        List(viewModel.movies) { movies in
            HStack {
                AsyncImage(url: movies.posterUrl) { state in
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
                    Text(movies.title)
                        .font(.headline)
                    Text(movies.overview)
                        .font(.caption)
                        .lineLimit(3)
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
