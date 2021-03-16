//
//  FavoriteViewModel.swift
//  GGGaming
//
//  Created by Agus Tiyansyah Syam on 15/03/21.
//

import Foundation

class FavoriteViewModel: ObservableObject {

    private var provider: GameProvider
    @Published var games = [Game]()

    init(provider: GameProvider = GameProvider()) {
        self.provider = provider
    }

    func getAllFavoriteGame() {
        self.provider.getAllFavoriteGame(completion: { (games) in
            DispatchQueue.main.async {
                self.games = games
                print(games.count)
            }
        })
    }
}
