//
//  EditProfilePage.swift
//  GGGaming
//
//  Created by Agus Tiyansyah Syam on 16/03/21.
//

import SwiftUI

struct EditProfilePage: View {

    @State var name: String = ""
    @State var about: String = ""
    @State var emptyField = false

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Name")
                    .bold()
                TextField("Name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Text("About")
                    .bold()
                TextField("About...", text: $about)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                HStack {
                    Spacer()
                    Button(action: {
                        if !name.isEmpty && !about.isEmpty {
                            print("Save profile")
                            ProfileModel.name = name
                            ProfileModel.about = about

                            self.presentationMode.wrappedValue.dismiss()
                        } else {
                            emptyField = true
                        }
                    }, label: {
                        Text("Save")
                    })
                    .padding(.top)
                    .alert(isPresented: $emptyField, content: {
                        Alert(title: Text("Warning"), message: Text("Please fill in all fields!"), dismissButton: .default(Text("OK")))
                    })
                    Spacer()
                }
            }
            .padding()
            .onAppear {
                if !ProfileModel.name.isEmpty && !ProfileModel.about.isEmpty {
                    name = ProfileModel.name
                    about = ProfileModel.about
                } else {
                    name = "Agus Tiyansyah Syam"
                    about = "IT Student - Aspiring iOS Developer"
                }
            }
        }
    }
}

struct EditProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        EditProfilePage()
    }
}
