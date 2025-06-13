//
//  ImagePreviewButtonsView.swift
//  PhotoPickerDemo
//
//  Created by Andrea Consorti on 13/06/25.
//

import SwiftUI
import SwiftUICore

struct PhotoPickerToolbar {
    
    static func toolbarItems(
        selectedImages: Binding<[UIImage]>,
        showOptions: Binding<Bool>,
        onImageRemoved: @escaping () -> Void,
        onImageAdded: @escaping () -> Void
    ) -> some ToolbarContent {
        
        return ToolbarItemGroup(placement: .navigationBarTrailing) {
            if !selectedImages.isEmpty {
                Button(action: {
                    onImageAdded()
                }) {
                    Image(systemName: "photo.badge.plus")
                        .foregroundColor(Color.blue)
                }
                
                Button(action: {
                    onImageRemoved()
                }) {
                    Image(systemName: "xmark.circle")
                        .foregroundColor(Color.red)
                }
                
                
            }
            else {
                Button(action: {
                    showOptions.wrappedValue = true
                }) {
                    Image(systemName: "plus.circle")
                        .foregroundColor(Color.blue)
                }
            }
            
        }
       
    }
    
}
