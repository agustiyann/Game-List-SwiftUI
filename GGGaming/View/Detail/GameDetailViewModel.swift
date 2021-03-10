//
//  GameDetailViewModel.swift
//  GGGaming
//
//  Created by Agus Tiyansyah Syam on 10/03/21.
//

import Foundation

class GameDetailViewModel: ObservableObject {
    private let gameService = GameService()
    
    @Published var detail: GameDetail?
    @Published var isLoading = false
    
    func fetchGameDetail(id: Int) {
        self.isLoading = true
        self.gameService.getGameDetail(id: id, completion: { [weak self] (result) in
            var gameDetail: GameDetail?
            switch result {
                case .success(let detailOf):
                    gameDetail = detailOf
                case .failure(let error):
                    print("Error processinng json data: \(error)")
            }
            
            self?.isLoading = false
            self?.detail = gameDetail
        })
    }
}
