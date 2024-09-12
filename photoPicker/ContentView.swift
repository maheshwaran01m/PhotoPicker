//
//  ContentView.swift
//  photoPicker
//
//  Created by MAHESHWARAN on 05/08/23.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
  
  @State private var avatarItem: PhotosPickerItem?
  @State private var avatarImage: Image?
  
  var body: some View {
    VStack {
      avatarImageView
      PhotosPicker("Select avatar", selection: $avatarItem, matching: .images)
    }
    .onChange(of: avatarItem, perform: updateAvatarImage)
  }
  
  @ViewBuilder
  private var avatarImageView: some View {
    if let avatarImage {
      avatarImage
        .resizable()
        .scaledToFit()
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .frame(width: 300, height: 300)
    }
  }
}

extension ContentView {
  
  private func updateAvatarImage(_ picker: PhotosPickerItem?) {
    Task {
      guard let data = try? await avatarItem?.loadTransferable(type: Data.self),
            let uiImage = UIImage(data: data) else {
        print("Failed")
        return
      }
      avatarImage = Image(uiImage: uiImage)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
