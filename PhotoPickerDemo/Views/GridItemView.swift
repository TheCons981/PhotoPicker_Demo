//
//  GridItemView.swift
//  PhotoPickerDemo
//
//  Created by Andrea Consorti on 13/06/25.
//

import SwiftUICore
import SwiftUI

struct GridItemView: View {
    
    @EnvironmentObject var viewModel: PhotoPickerViewModel
    
    @Binding var selectableImage: SelectableImage
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            GeometryReader { gr in
                Image(uiImage: selectableImage.image)
                    .resizable()
                    .transition(.opacity)
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width/3, height: UIScreen.main.bounds.width/3)
                    .clipped()
                    .contentShape(Path(CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width/3, height: UIScreen.main.bounds.width/3)))
                    .background(
                        selectableImage.isSelected && viewModel.isGridInSelectionMode
                        ? Color.blue.opacity(0.2)
                        : Color.clear
                    )
                    .onTapGesture {
                        if viewModel.isGridInSelectionMode {
                            selectableImage.isSelected.toggle()
                        }
                    }
                if selectableImage.isSelected && viewModel.isGridInSelectionMode {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.blue)
                        .padding(6)
                }
            }
        }
        .clipped()
        .aspectRatio(1, contentMode: .fit)
        .border(Color(UIColor.systemBackground))
        .padding(0)
    }
    
}


