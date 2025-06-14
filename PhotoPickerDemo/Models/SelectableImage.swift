//
//  SelectableImage.swift
//  PhotoPickerDemo
//
//  Created by Andrea Consorti on 14/06/25.
//

import SwiftUI

struct SelectableImage: Identifiable, Equatable {
    
    let id: UUID
    let image: UIImage
    var isSelected: Bool

    
    init(image: UIImage, isSelected: Bool = false) {
        self.id = UUID()
        self.image = image
        self.isSelected = isSelected
    }
    
}
