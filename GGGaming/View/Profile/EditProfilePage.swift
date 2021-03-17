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

    @State var image: Image?
    @State var showingImagePicker = false
    @State var inputImage: UIImage?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    if image != nil {
                        Spacer()
                        image?
                            .resizable()
                            .scaledToFill()
                            .frame(width: 200, height: 200, alignment: .center)
                            .cornerRadius(100)
                            .overlay(
                                Image(systemName: "pencil")
                                    .resizable()
                                    .foregroundColor(.white)
                                    .scaledToFill()
                                    .frame(width: 40, height: 40)
                                    .opacity(0.5)
                            )
                            .onTapGesture {
                                self.showingImagePicker = true
                            }
                        Spacer()
                    } else {
                        Spacer()
                        Image("me")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 200, height: 200, alignment: .center)
                            .cornerRadius(100)
                            .overlay(
                                Image(systemName: "pencil")
                                    .resizable()
                                    .foregroundColor(.white)
                                    .scaledToFill()
                                    .frame(width: 40, height: 40)
                                    .opacity(0.5)
                            )
                            .onTapGesture {
                                self.showingImagePicker = true
                            }
                        Spacer()
                    }
                }

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

                        if inputImage != nil {
                            ProfileModel.image = (inputImage?.jpegData(compressionQuality: 1.0)!)!
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
            .navigationBarTitle(Text("Edit Profile"), displayMode: .inline)
            .padding()
            .onAppear {
                if !ProfileModel.name.isEmpty && !ProfileModel.about.isEmpty {
                    name = ProfileModel.name
                    about = ProfileModel.about
                    self.image = Image(uiImage: UIImage(data: ProfileModel.image) ?? UIImage(imageLiteralResourceName: "me"))
                } else {
                    name = "Agus Tiyansyah Syam"
                    about = "IT Student - Aspiring iOS Developer"
                }
            }
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage, content: {
                ImagePicker(image: self.$inputImage)
            })
        }
    }

    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
}

struct EditProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EditProfilePage()
        }
    }
}
