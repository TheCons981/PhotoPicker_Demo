//
//  ImageSection.swift
//  PhotoPickerDemo
//
//  Created by Andrea Consorti on 13/06/25.
//

import SwiftUICore
import SwiftUI

struct ImagePreviewView: View {
    let images: [UIImage]
    var body: some View {
        if !images.isEmpty {
            /*Image(uiImage: image)
             .resizable()
             .scaledToFit()
             .frame(height: 500)
             .cornerRadius(12)
             .shadow(radius: 5)*/
            TabView {
                ForEach(images, id: \.self) { image in
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 340)
                        .cornerRadius(16)
                        .shadow(radius: 8)
                        .padding()
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            //.frame(height: 400)
            
        } else {
            Text("No images selected")
                .foregroundColor(.gray)
        }
    }
}
