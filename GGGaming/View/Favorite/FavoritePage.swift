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
                    List(self.viewModel.games) { game in
                        ZStack {
                            GameRow(game: game)
                            NavigationLink(destination: GameDetailPage(id: game.id ?? 1)) {
                                EmptyView()
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
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
            .navigationBarTitle(Text("Favorite"), displayMode: .inline)
        }
    }
}

struct FavoritePage_Previews: PreviewProvider {
    static var previews: some View {
        FavoritePage()
    }
}
