//
//  FavoritePage.swift
//  GGGaming
//
//  Created by Agus Tiyansyah Syam on 15/03/21.
//

import SwiftUI

struct FavoritePage: View {

    @ObservedObject var viewModel: FavoriteViewModel = FavoriteViewModel()

    var body: some View {
        VStack {
            if !self.viewModel.games.isEmpty {
                ScrollView(showsIndicators: false) {
                    LazyVStack {
                        ForEach(self.viewModel.games, id: \.id) { game in
                            NavigationLink(destination: GameDetailPage(id: game.id ?? 1, origin: "favorite")) {
                                ZStack {
                                    GameRow(game: game)
                                }
                            }
                        }
                    }
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                }
            } else {
                Spacer()
                Text("No favorite game.")
                    .bold()
                Text("Add your favorite games!")
                Spacer()
            }
        }
        .onAppear {
            self.viewModel.getAllFavoriteGame()
        }
        .navigationTitle("Favorite")
    }
}

struct FavoritePage_Previews: PreviewProvider {
    static var previews: some View {
        FavoritePage()
    }
}
