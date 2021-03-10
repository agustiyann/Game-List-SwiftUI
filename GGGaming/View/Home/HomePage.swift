//
//  HomePage.swift
//  GGGaming
//
//  Created by Agus Tiyansyah Syam on 07/03/21.
//

import Foundation
import SwiftUI

struct HomePage: View {
    
    @ObservedObject var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if !viewModel.isLoading {
                    if viewModel.games.count != 0 {
                        HomeGameList(games: self.viewModel.games)
                    }
                } else {
                    VStack(spacing: 1) {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .green))
                            .scaleEffect(x: 2, y: 2, anchor: .center)
                    }
                }
            }
            .onAppear {
                self.viewModel.fetchGame()
            }
        }
    }
}

struct HomeGameList: View {
    
    var games = [Game]()
    
    var body: some View {
        if #available(iOS 14, *) {
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    ForEach(games, id: \.id) { game in
                        NavigationLink(destination: GameDetailPage(id: game.id)) {
                            ZStack {
                                GameRow(game: game)
                            }
                        }
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            }
            .navigationBarTitle("Game List", displayMode: .large)
        } else {
            List(self.games) { game in
                ZStack {
                    GameRow(game: game)
                    NavigationLink(destination: GameDetailPage(id: game.id)) {
                        EmptyView()
                    }
                }
            }
            .navigationBarTitle("Game List", displayMode: .large)
            .listStyle(PlainListStyle())
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
