//
//  GameRow.swift
//  GGGaming
//
//  Created by Agus Tiyansyah Syam on 07/03/21.
//

import Foundation
import SwiftUI

struct GameRow: View {
    
    var game: Game
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0, content: {
            Image("gtav")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(10)
                .clipped()
                .overlay(
                    VStack(alignment: .center) {
                        Text(String(game.rating))
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.yellow)
                            .clipShape(Circle())
                            .opacity(0.8)
                        
                        Text(game.released)
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .padding(4)
                            .background(Color.green)
                            .cornerRadius(4)
                    }
                    .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 10)),
                    alignment: .topTrailing
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.black)
                        .opacity(0.3)
                        .frame(height: 50)
                        .overlay(
                            Text(game.name)
                                .fontWeight(.heavy)
                                .font(.system(.title2))
                                .foregroundColor(.white)
                                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)),
                            alignment: .leading
                        ),
                    alignment: .bottom
                )
        })

    }
}

struct GameRow_Previews: PreviewProvider {
    static var previews: some View {
        GameRow(game: Game(id: 1, name: "GTA V", released: "21-08-2018", backgroundImage: "ahmad_dahlan", rating: 4.5, metaScore: 97, playtime: 69))
            .previewLayout(.fixed(width: 400, height: 400))
    }
}
