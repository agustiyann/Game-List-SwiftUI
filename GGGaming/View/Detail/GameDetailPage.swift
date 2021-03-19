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

    var body: some View {
        VStack {
            if !self.viewModel.isLoading {
                if self.viewModel.isSuccess {
                    if self.viewModel.detail != nil {
                        GameDetailView(viewModel: self.viewModel, game: self.viewModel.detail!)
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

struct GameDetailPage_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            GameDetailView(
                viewModel: GameDetailViewModel(),
                game: GameDetail(id: 1, name: "GTA V", description: "Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet.", released: Date(), backgroundImage: "gtav", rating: 4.32, metaScore: 98, playtime: 97, genres: [Genre]())
            )
        }
    }
}
