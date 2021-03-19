//
//  ProfilePage.swift
//  GGGaming
//
//  Created by Agus Tiyansyah Syam on 11/03/21.
//

import SwiftUI

struct ProfilePage: View {

    @State var linkEdit = false
    @State var name: String = ""
    @State var about: String = ""
    @State var image: Image?

    var body: some View {
        NavigationView {
            VStack(alignment: .center, content: {
                if image != nil {
                    image?
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200, alignment: .center)
                        .cornerRadius(100)
                        .padding(.top)
                } else {
                    Image("me")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200, alignment: .center)
                        .cornerRadius(100)
                        .padding(.top)
                }

                Text(name)
                    .font(.title3)
                    .fontWeight(.bold)
                Text(about)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .padding()
                Spacer()
            })
            .onAppear {
                ProfileModel.synchronize()
                if !ProfileModel.name.isEmpty && !ProfileModel.about.isEmpty {
                    name = ProfileModel.name
                    about = ProfileModel.about
                    self.image = Image(uiImage: UIImage(data: ProfileModel.image) ?? UIImage(imageLiteralResourceName: "me"))
                } else {
                    name = "Agus Tiyansyah Syam"
                    about = "IT Student - Aspiring iOS Developer"
                }
            }
            .background(
                NavigationLink(
                    destination: EditProfilePage(), isActive: $linkEdit) {}
            )
            .navigationBarTitle(Text("Profile"), displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { linkEdit = true }, label: {
                        Image(systemName: "square.and.pencil")
                    })
                }
            }
        }
    }
}

struct ProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePage()
    }
}
