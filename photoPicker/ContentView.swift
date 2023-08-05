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
      if let avatarImage {
        avatarImage
          .resizable()
          .scaledToFit()
          .clipShape(RoundedRectangle(cornerRadius: 8))
          .frame(width: 300, height: 300)
        
      }
      PhotosPicker("Select avatar", selection: $avatarItem, matching: .images)
    }
    .onChange(of: avatarItem) { _ in
      Task {
        if let data = try? await avatarItem?.loadTransferable(type: Data.self) {
          if let uiImage = UIImage(data: data) {
            avatarImage = Image(uiImage: uiImage)
            return
          }
        }
        
        print("Failed")
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
