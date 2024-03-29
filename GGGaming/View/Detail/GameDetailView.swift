//
//  GameDetailView.swift
//  GGGaming
//
//  Created by Agus Tiyansyah Syam on 19/03/21.
//

import SwiftUI
import Kingfisher

struct GameDetailView: View {

    @ObservedObject var viewModel: GameDetailViewModel

    var game: GameDetail

    func addToFavorite() {
        self.viewModel.addToFavorite(game: Game(id: game.id, name: game.name, released: game.released, backgroundImage: game.backgroundImage, rating: game.rating, metaScore: game.metaScore, playtime: game.playtime))
    }

    func deleteFromFavorite() {
        self.viewModel.deleteFromFavorite(id: self.game.id ?? 1)
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                KFImage(URL(string: game.backgroundImage ?? ""))
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.size.width, height: 250, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .clipped()
                Spacer()

                Text(game.name ?? "No name")
                    .fontWeight(.heavy)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))

                Text("\(game.released?.convertToString(format: "MMM dd, yyyy") ?? "No data released")")
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                Spacer()

                Text("About")
                    .fontWeight(.heavy)
                    .font(.title2)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                Spacer()

                Text(game.description ?? "No description")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                Divider()

                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        Text("Rating")
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                        Text(String(game.rating ?? 0.0))
                        Text("Genre")
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                            .padding(.top)
                        ForEach(game.genres ?? [Genre]()) { genre in
                            Text(genre.name)
                        }
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    VStack(alignment: .leading) {
                        Text("Metascore")
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                        Text(String(game.metaScore ?? 0))
                        Text("Average playtime")
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                            .padding(.top)
                        Text("\(game.playtime ?? 0) Hours")
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                }
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 0))
            }
        }
        .navigationBarTitle("Detail", displayMode: .large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if self.viewModel.isFavorite {
                    Button(action: {
                        self.deleteFromFavorite()
                    }, label: {
                        Image(systemName: "heart.fill")
                    })
                } else {
                    Button(action: {
                        self.addToFavorite()
                    }, label: {
                        Image(systemName: "heart")
                    })
                }
            }
        }
    }

}

struct GameDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            GameDetailView(viewModel: GameDetailViewModel(),
                           game: GameDetail(id: 1, name: "GTA V", description: "Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet.", released: Date(), backgroundImage: "gtav", rating: 4.32, metaScore: 98, playtime: 97, genres: [Genre]()))
        }
    }
}
