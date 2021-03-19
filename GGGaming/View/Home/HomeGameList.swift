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

struct HomeGameList_Previews: PreviewProvider {
    static var previews: some View {
        HomeGameList()
    }
}
