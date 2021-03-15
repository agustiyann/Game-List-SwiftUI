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
        NavigationView {
            VStack {
                if !self.viewModel.games.isEmpty {
                    ScrollView(showsIndicators: false) {
                        LazyVStack {
                            ForEach(self.viewModel.games, id: \.id) { game in
                                NavigationLink(destination: GameDetailPage(id: game.id ?? 1)) {
                                    ZStack {
                                        GameRow(game: game)
                                    }
                                }
                            }
                        }
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                    }
                } else {
                    Spacer()
                    Text("No favorite game.")
                        .bold()
                    Text("Add your favorite games!")
                    Spacer()
                }
            }
        }
    }
}

struct FavoritePage_Previews: PreviewProvider {
    static var previews: some View {
        FavoritePage()
    }
}
