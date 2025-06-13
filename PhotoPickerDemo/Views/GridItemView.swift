//
//  GridItemView.swift
//  PhotoPickerDemo
//
//  Created by Andrea Consorti on 13/06/25.
//

import SwiftUICore
import SwiftUI

struct GridItemView: View {
    let image: UIImage
    
    var body: some View {
        ZStack {
            GeometryReader { gr in
                Image(uiImage: image)
                    .resizable()
                    .transition(.opacity)
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width/3, height: UIScreen.main.bounds.width/3)
                    .clipped()
                    .contentShape(Path(CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width/3, height: UIScreen.main.bounds.width/3)))
            }
        }
        .clipped()
        .aspectRatio(1, contentMode: .fit)
        .border(Color(UIColor.systemBackground))
        .padding(0)
    }
    
}


