//
//  ImagePreviewButtonsView.swift
//  PhotoPickerDemo
//
//  Created by Andrea Consorti on 13/06/25.
//

import SwiftUI
import SwiftUICore

struct PhotoGridToolbar {
    
    static func toolbarItems(
        selectedImagesCount: Int,
        isSelectionMode: Binding<Bool>,
        onInitSelectableImages: @escaping () -> Void,
        onImagesRemoved: @escaping () -> Void
    ) -> some ToolbarContent {
        print(selectedImagesCount)
        return ToolbarItemGroup(placement: .navigationBarTrailing) {

            if !isSelectionMode.wrappedValue {
                Button(action: {
                    
                    isSelectionMode.wrappedValue.toggle()
                    
                }) {
                    Image(systemName: "minus.circle")
                        .foregroundColor(Color.red)
                        
                }
                
            }
            else {
                
                
                Button(action: {
                    isSelectionMode.wrappedValue.toggle()
                    onImagesRemoved()
                }) {
                    Image(systemName: "trash.circle")
                        .foregroundColor(selectedImagesCount <= 0 ? Color.gray : Color.red)
                }
                .disabled(selectedImagesCount <= 0)
                
                
                Button(action: {
                    isSelectionMode.wrappedValue.toggle()
                    onInitSelectableImages();
                }) {
                    Image(systemName: "xmark.circle")
                        .foregroundColor(Color.blue)
                }
            }
            
        }
        
    }
}
