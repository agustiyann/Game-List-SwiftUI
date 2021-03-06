//
//  HomeViewModel.swift
//  GGGaming
//
//  Created by Agus Tiyansyah Syam on 07/03/21.
//

import Foundation

class HomeViewModel: ObservableObject {
    private let gameService = GameService()

    @Published var games = [Game]()
    @Published var isLoading = false
    @Published var isSuccess = true
    @Published var query = "" {
        didSet {
            self.fetchGame()
        }
    }

    func fetchGame() {
        self.isLoading = true
        self.gameService.getGameList(query: self.query, completion: { [weak self] (result) in
            var gameResult = [Game]()
            var success = true

            switch result {
            case .success(let listOf):
                gameResult = listOf.results
            case .failure(let error):
                print("Error processinng json data: \(error)")
                success = false
            }

            DispatchQueue.main.async {
                self?.isLoading = false
                self?.isSuccess = success
                self?.games = gameResult
            }
        })
    }
}
