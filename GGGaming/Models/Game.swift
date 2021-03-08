//
//  Game.swift
//  GGGaming
//
//  Created by Agus Tiyansyah Syam on 07/03/21.
//

import Foundation

struct GameResponse: Decodable {
    let results: [Game]
}

struct Game: Decodable, Identifiable {
    let id: Int
    let name: String
    let released: String
    let backgroundImage: String?
    let rating: Double
    let metaScore: Int
    let playtime: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case released
        case backgroundImage = "background_image"
        case rating
        case metaScore = "metacritic"
        case playtime
    }
}
