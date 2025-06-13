//
//  ImagePreviewButtonsView.swift
//  PhotoPickerDemo
//
//  Created by Andrea Consorti on 13/06/25.
//

import SwiftUI
import SwiftUICore

struct ImagePreviewButtonsView: View {
    let images: [UIImage]
    @Binding var showOptions: Bool
    var onImageRemoved: () -> Void
    var onImageAdded: () -> Void
    
    var body: some View {
        if !images.isEmpty {
            HStack {
                Button("Remove images") {
                    onImageRemoved()
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                Button("Add to grid") {
                    onImageAdded()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                
            }
            
            Text("Swipe right/left if you selected more than one time").font(.caption)
            
        } else {
            
            Button("Select images") {
                showOptions = true
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            
        }
    }
}
