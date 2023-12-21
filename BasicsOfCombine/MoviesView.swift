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
        List(viewModel.moviesUpcoming) { movies in
                HStack {
                    AsyncImage(url: movies.posterUrl) { poster in
                        poster
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100)
                    } placeholder: {
                        ProgressView()
                            .frame(width: 100)
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
        .onAppear() {
            viewModel.fetchInitialData()
        }
    }
}

#Preview {
    MoviesView()
}
