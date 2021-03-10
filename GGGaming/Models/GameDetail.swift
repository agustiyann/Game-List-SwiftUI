//
//  GameDetail.swift
//  GGGaming
//
//  Created by Agus Tiyansyah Syam on 08/03/21.
//

import Foundation

struct GameDetailResponse: Decodable {
    let results: [GameDetail]
}

struct GameDetail: Decodable, Identifiable {
    let id: Int
    let name: String
    let description: String
    let released: String
    let backgroundImage: String?
    let rating: Double
    let metaScore: Int
    let playtime: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description = "description_raw"
        case released
        case backgroundImage = "background_image"
        case rating
        case metaScore = "metacritic"
        case playtime
    }
}
