//
//  GameDetailPage.swift
//  GGGaming
//
//  Created by Agus Tiyansyah Syam on 08/03/21.
//

import SwiftUI
import Kingfisher

struct GameDetailPage: View {

    @ObservedObject var viewModel = GameDetailViewModel()
    var id: Int
    var origin: String

    init(id: Int, origin: String) {
        self.id = id
        self.origin = origin
    }

    var body: some View {
        VStack {
            if !self.viewModel.isLoading {
                if self.viewModel.isSuccess {
                    if self.viewModel.detail != nil {
                        GameDetailView(viewModel: self.viewModel, game: self.viewModel.detail!, origin: self.origin)
                    } else {
                        Spacer()
                        Text("No detail data!")
                            .bold()
                        Spacer()
                    }
                } else {
                    Spacer()
                    Text("Something went wrong!")
                        .bold()
                    Text("Try again later!")
                    Spacer()
                }
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
    var origin: String

    enum ActiveAlert {
        case exist, noExist
    }

    @State private var showAlert = false
    @State private var activeAlert: ActiveAlert = .exist
    @State private var deleted = false

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
            ToolbarItem(placement: .status) {
                switch origin {
                case "home":
                    Button(action: {
                        if !self.viewModel.checkIsExist(id: game.id!) {
                            self.activeAlert = .noExist
                            self.viewModel.addToFavorite(game: Game(id: game.id, name: game.name, released: game.released, backgroundImage: game.backgroundImage, rating: game.rating, metaScore: game.metaScore, playtime: game.playtime))
                            print("add to favorite")
                        } else {
                            self.activeAlert = .exist
                            print("add to favorite exist")
                        }
                        self.showAlert = true
                    }, label: {
                        Text("Add to Favorite")
                            .bold()
                            .foregroundColor(.green)
                    })
                    .alert(isPresented: $showAlert, content: {
                        switch activeAlert {
                        case .exist:
                            return Alert(title: Text("Already Exist!"), message: Text("The game you choose is already in the favorites list."))
                        case .noExist:
                            return Alert(title: Text("Added Successfuly."), message: Text("The game has been successfully added to the favorites list"))
                        }
                    })
                case "favorite":
                    Button(action: {
                        self.viewModel.deleteFromFavorite(id: game.id!)
                        self.deleted = true
                    }, label: {
                        Text("Delete from Favorite")
                            .bold()
                            .foregroundColor(.red)
                    })
                    .alert(isPresented: $deleted, content: {
                        Alert(title: Text("Deleted Successfuly."), message: Text("The game has been successfully deleted from the favorites list"))
                    })
                default:
                    Button(action: {}, label: {
                        Text("-")
                    })
                }
            }
        }
    }

}

struct GameDetailPage_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            GameDetailView(
                viewModel: GameDetailViewModel(),
                game: GameDetail(id: 1, name: "GTA V", description: "Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet.", released: Date(), backgroundImage: "gtav", rating: 4.32, metaScore: 98, playtime: 97, genres: [Genre]()),
                origin: "favorite"
            )
        }
    }
}
