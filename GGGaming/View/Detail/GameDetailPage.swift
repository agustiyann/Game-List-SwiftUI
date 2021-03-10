//
//  GameDetailPage.swift
//  GGGaming
//
//  Created by Agus Tiyansyah Syam on 08/03/21.
//

import Foundation
import SwiftUI

struct GameDetailPage: View {
    
    var id: Int
    
    var body: some View {
        ScrollView {
            VStack {
//                Image("gtav")
//                    .resizable()
//                    .scaledToFill()
//                    .frame(width: UIScreen.main.bounds.size.width, height: 250, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                    .clipped()
//                Spacer()
//                Text(game.name)
//                    .fontWeight(.heavy)
//                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
//                Text(game.released)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
//                Spacer()
//                Text("About")
//                    .fontWeight(.heavy)
//                    .font(.headline)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                Text(String(id))
            }
        }
        .navigationBarTitle("Detail", displayMode: .large)
    }
}

struct GameDetailPage_Previews: PreviewProvider {
    static var previews: some View {
        GameDetailPage(id: 2)
    }
}
