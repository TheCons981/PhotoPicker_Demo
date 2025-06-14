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
                        ForEach($viewModel.selectedImages, id: \.id) { $selectableImage in
                            withAnimation{
                                GridItemView(selectableImage: $selectableImage)
                                    .environmentObject(viewModel)
                            }
                        }
                    }
                }
            }
            .toolbar(){
                
                PhotoGridToolbar.toolbarItems(
                    selectedImagesCount: viewModel.countImagesToRemove,
                    isSelectionMode: $viewModel.isGridInSelectionMode,
                    onInitSelectableImages: {
                    viewModel.initSelectableImages()
                }, onImagesRemoved: {
                    viewModel.removeSelectedImages()
                })
                
                ToolbarItem(placement: .principal){
                    Text("Selected Photos").bold().font(.title2)
                }
            }
        }
    }
}
