//
//  HomeGameList.swift
//  GGGaming
//
//  Created by Agus Tiyansyah Syam on 19/03/21.
//

import SwiftUI

struct HomeGameList: View {

    var games = [Game]()

    var body: some View {
        if #available(iOS 14, *) {
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    ForEach(games, id: \.id) { game in
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
            List(self.games) { game in
                ZStack {
                    GameRow(game: game)
                    NavigationLink(destination: GameDetailPage(id: game.id ?? 1)) {
                        EmptyView()
                    }
                }
            }
            .listStyle(PlainListStyle())
        }
    }
}

struct HomeGameList_Previews: PreviewProvider {
    static var previews: some View {
        HomeGameList()
    }
}
