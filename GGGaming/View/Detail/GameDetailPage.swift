//
//  GameDetailPage.swift
//  GGGaming
//
//  Created by Agus Tiyansyah Syam on 08/03/21.
//

import Foundation
import SwiftUI
import Kingfisher

struct GameDetailPage: View {
    
    @ObservedObject var viewModel = GameDetailViewModel()
    var id: Int
    
    init(id: Int) {
        self.id = id
    }
    
    var body: some View {
        VStack {
            if self.viewModel.detail != nil {
                GameDetailView(viewModel: self.viewModel, game: self.viewModel.detail!)
            } else {
                VStack {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .green))
                        .scaleEffect(x: 2, y: 2, anchor: .center)
                }
            }
        }
        .onAppear {
            self.viewModel.fetchGameDetail(id: self.id)
        }
    }
    
}

struct GameDetailView: View {
    
    @ObservedObject var viewModel: GameDetailViewModel
    var game: GameDetail
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                KFImage(URL(string: game.backgroundImage!))
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.size.width, height: 250, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .clipped()
                Spacer()
                Text(game.name)
                    .fontWeight(.heavy)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                Text(game.released.convertToString(format: "MMM dd, yyyy"))
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                Spacer()
                Text("About")
                    .fontWeight(.heavy)
                    .font(.title2)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                Spacer()
                Text(game.description)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                Divider()
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        Text("Rating")
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                        Text(String(game.rating))
                        Text("Genre")
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                            .padding(.top)
                        ForEach(game.genres) { genre in
                            Text(genre.name)
                        }
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    VStack(alignment: .leading) {
                        Text("Metascore")
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                        Text(String(game.metaScore))
                        Text("Average playtime")
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                            .padding(.top)
                        Text("\(game.playtime) Hours")
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                }
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 0))
            }
        }
        .navigationBarTitle("Detail", displayMode: .large)
    }
    
}

struct GameDetailPage_Previews: PreviewProvider {
    static var previews: some View {
        GameDetailView(viewModel: GameDetailViewModel(), game: GameDetail(id: 1, name: "GTA V", description: "Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet.", released: Date(), backgroundImage: "gtav", rating: 4.32, metaScore: 98, playtime: 97, genres: [Genre]()))
    }
}
