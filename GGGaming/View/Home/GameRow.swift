//
//  GameRow.swift
//  GGGaming
//
//  Created by Agus Tiyansyah Syam on 07/03/21.
//

import SwiftUI
import Kingfisher

struct GameRow: View {

    var game: Game

    var body: some View {
        VStack(alignment: .leading, spacing: 0, content: {
            KFImage(URL(string: game.backgroundImage ?? ""))
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.size.width - 40, height: UIScreen.main.bounds.size.height / 4)
                .cornerRadius(10)
                .clipped()
                .overlay(
                    Rectangle()
                        .frame(height: 30)
                        .foregroundColor(.clear)
                        .background(RoundedCorners(color: Color.black, oppacity: 0.3, topLeft: 10, topRight: 10, bottomLeft: 0, bottomRight: 0))
                        .overlay(
                            Text("🗓 \(game.released?.convertToString(format: "MMM dd, yyyy") ?? "") ⭐️ \(String(game.rating ?? 0.0))")
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
                        .background(RoundedCorners(color: Color.black, oppacity: 0.3, topLeft: 0, topRight: 0, bottomLeft: 10, bottomRight: 10))
                        .frame(height: 40)
                        .overlay(
                            Text(game.name ?? "")
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
        GameRow(game: Game(id: 1, name: "GTA V", released: Date(), backgroundImage: "gtav", rating: 4.5, metaScore: 97, playtime: 69))
    }
}
