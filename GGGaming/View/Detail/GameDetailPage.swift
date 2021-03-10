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
        ScrollView {
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
                Text(game.released)
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
                Spacer()
                HStack {
                    VStack(alignment: .leading) {
                        Text("Platform")
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                        Text("PC, Xbox")
                        Spacer()
                        Text("Genre")
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                        Text("Action, Adventure")
                    }
                    .scaledToFit()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    VStack(alignment: .leading) {
                        Text("Metascore")
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                        Text(String(game.metaScore))
                        Spacer()
                        Text("Average playtime")
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                        Text("\(game.playtime) Hours")
                    }
                    .scaledToFit()
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 0))
            }
        }
        .navigationBarTitle("Detail", displayMode: .large)
    }
    
}

struct GameDetailPage_Previews: PreviewProvider {
    static var previews: some View {
        GameDetailView(viewModel: GameDetailViewModel(), game: GameDetail(id: 1, name: "GTA V", description: "Lorem ipsum dolor sit amet.", released: "17-08-2013", backgroundImage: "gtav", rating: 4.3, metaScore: 96, playtime: 70))
    }
}
