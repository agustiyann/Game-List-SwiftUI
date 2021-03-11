//
//  ProfilePage.swift
//  GGGaming
//
//  Created by Agus Tiyansyah Syam on 11/03/21.
//

import SwiftUI

struct ProfilePage: View {
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 2, content: {
            Image("me")
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 200, alignment: .center)
                .cornerRadius(100)
                .padding(.top)
            Text("Agus Tiyansyah Syam")
                .font(.title3)
                .fontWeight(.bold)
            Text("| 🎓 IT Undergraduate | 👨🏻‍💻 Aspiring iOS Developer | 🐣 1999 | 🐈 Meowed | ☕️ CoffeeIn |")
                .frame(minWidth: 0, maxWidth: .infinity)
                .multilineTextAlignment(.center)
                .padding()
            Spacer()
        })
        .navigationTitle("Profile")
    }
}

struct ProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePage()
    }
}
