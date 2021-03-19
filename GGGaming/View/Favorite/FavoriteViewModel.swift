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
    @Published var isLoading = false

    init(provider: GameProvider = GameProvider()) {
        self.provider = provider
    }

    func getAllFavoriteGame() {
        self.isLoading = true
        self.provider.getAllFavoriteGame(completion: { (games) in
            DispatchQueue.main.async {
                self.isLoading = false
                self.games = games
                print(games.count)
            }
        })
    }
}
