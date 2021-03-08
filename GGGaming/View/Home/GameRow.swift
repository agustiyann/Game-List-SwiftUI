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
                    Rectangle()
                        .frame(height: 30)
                        .foregroundColor(.clear)
                        .background(RoundedCorners(color: Color.black, oppacity: 0.3, tl: 10, tr: 10, bl: 0, br: 0))
                        .overlay(
                            Text("🗓 \(game.released) ⭐️ \(String(game.rating))")
                                .fontWeight(.heavy)
                                .font(.system(.caption))
                                .foregroundColor(.white)
                                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)),
                            alignment: .trailing
                        ),
                    alignment: .top
                )
                .overlay(
                    Rectangle()
                        .foregroundColor(.clear)
                        .background(RoundedCorners(color: Color.black, oppacity: 0.3, tl: 0, tr: 0, bl: 10, br: 10))
                        .frame(height: 50)
                        .overlay(
                            Text(game.name)
                                .fontWeight(.heavy)
                                .font(.system(.title2))
                                .lineLimit(1)
                                .foregroundColor(.white)
                                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)),
                            alignment: .leading
                        ),
                    alignment: .bottom
                )
        })
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))

    }
}

struct GameRow_Previews: PreviewProvider {
    static var previews: some View {
        GameRow(game: Game(id: 1, name: "GTA V", released: "21-08-2018", backgroundImage: "ahmad_dahlan", rating: 4.5, metaScore: 97, playtime: 69))
            .previewLayout(.fixed(width: 400, height: 400))
    }
}
