//
//  GameDetailViewModel.swift
//  GGGaming
//
//  Created by Agus Tiyansyah Syam on 10/03/21.
//

import Foundation

class GameDetailViewModel: ObservableObject {

    private let gameService = GameService()
    private let gameProvider = GameProvider()

    @Published var detail: GameDetail?
    @Published var isLoading = false
    @Published var isSuccess = true

    func fetchGameDetail(id: Int) {
        self.isLoading = true
        self.gameService.getGameDetail(id: id, completion: { [weak self] (result) in
            var gameDetail: GameDetail?
            var success = true

            switch result {
            case .success(let detailOf):
                gameDetail = detailOf
            case .failure(let error):
                success = false
                print("Error processinng json data: \(error)")
            }

            DispatchQueue.main.async {
                self?.isLoading = false
                self?.isSuccess = success
                self?.detail = gameDetail
            }
        })
    }

    func addToFavorite(game: Game) {
        self.gameProvider.addFavorite(game: game, completion: {
            DispatchQueue.main.async {

            }
        })
    }
}
