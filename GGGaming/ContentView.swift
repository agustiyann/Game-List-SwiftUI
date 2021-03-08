//
//  ContentView.swift
//  GGGaming
//
//  Created by Agus Tiyansyah Syam on 07/03/21.
//

import SwiftUI

struct ContentView: View {
    
    init() {
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().showsVerticalScrollIndicator = false
    }
        
    var body: some View {
        TabView {
            HomePage()
                .tabItem {
                    Image(systemName: "star")
                    Text("Home")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
