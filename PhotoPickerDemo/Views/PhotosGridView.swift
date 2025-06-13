//
//  SelectedPhotosGrid.swift
//  PhotoPickerDemo
//
//  Created by Andrea Consorti on 13/06/25.
//

import SwiftUICore
import SwiftUI

struct PhotosGridView: View {
    
    @EnvironmentObject var viewModel: PhotoPickerViewModel
    
    let columns = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0),
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                if viewModel.selectedImages.isEmpty {
                    VStack  {
                        Text("No images selected")
                            .foregroundColor(.gray)
                            .padding()
                    }
                    
                } else {
                    LazyVGrid(columns: columns, spacing: 0) {
                        ForEach(Array(viewModel.selectedImages.enumerated()), id: \.offset) { idx, img in
                            withAnimation{
                                GridItemView(image: img)
                            }
                        }
                    }
                }
            }
            .toolbar{
                ToolbarItem(placement: .principal){
                    Text("Selected Photos").bold().font(.title2)
                }
            }
        }
    }
}
