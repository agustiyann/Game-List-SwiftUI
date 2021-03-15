//
//  HomePage.swift
//  GGGaming
//
//  Created by Agus Tiyansyah Syam on 07/03/21.
//

import SwiftUI

struct HomePage: View {

    @ObservedObject var viewModel = HomeViewModel()

    @State var linkProfile = false
    @State var linkFavorite = false

    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                SearchBarView(placeHolder: "Search Games", text: self.$viewModel.query)
                    .listRowInsets(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))

                if !viewModel.isLoading {
                    if viewModel.isSuccess {
                        if !viewModel.games.isEmpty {
                            HomeGameList(games: self.viewModel.games)
                        } else {
                            Spacer()
                            Text("Data not found!")
                                .bold()
                            Text("Try another keyword!")
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
                        Spacer()
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .green))
                            .scaleEffect(x: 2, y: 2, anchor: .center)
                        Spacer()
                    }
                }
            }
            .onAppear {
                self.viewModel.fetchGame()
            }
            .background(
                NavigationLink(
                    destination: FavoritePage(), isActive: $linkFavorite) {}
            )
            .background(
                NavigationLink(
                    destination: ProfilePage(), isActive: $linkProfile) {}
            )
            .navigationBarTitle("Game List", displayMode: .inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: { linkFavorite = true }, label: {
                        Image(systemName: "star")
                    })
                    Button(action: { linkProfile = true }, label: {
                        Image(systemName: "person.circle")
                    })
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct HomeGameList: View {

    var games = [Game]()

    var body: some View {
        if #available(iOS 14, *) {
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    ForEach(games, id: \.id) { game in
                        NavigationLink(destination: GameDetailPage(id: game.id ?? 1)) {
                            ZStack {
                                GameRow(game: game)
                            }
                        }
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            }
        } else {
            List(self.games) { game in
                ZStack {
                    GameRow(game: game)
                    NavigationLink(destination: GameDetailPage(id: game.id ?? 1)) {
                        EmptyView()
                    }
                }
            }
            .listStyle(PlainListStyle())
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
