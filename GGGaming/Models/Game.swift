//
//  Game.swift
//  GGGaming
//
//  Created by Agus Tiyansyah Syam on 07/03/21.
//

import Foundation

struct GameResponse {
    let results: [Game]
}

struct Game {
    let id: Int
    let name: String
    let released: String
    let backgroundImage: String?
    let rating: Double
    let metaScore: Int
    let playtime: Int
}
