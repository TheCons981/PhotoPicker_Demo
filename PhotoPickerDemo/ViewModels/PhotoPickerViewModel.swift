//
//  PhotoPickerViewModel.swift
//  PhotoPickerDemo
//
//  Created by Andrea Consorti on 12/06/25.
//

import Foundation
import UIKit

@MainActor
class PhotoPickerViewModel: ObservableObject {
    @Published var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Published var selectedImages: [SelectableImage] = []
    @Published var isGridInSelectionMode: Bool = false
    
    @Published var showPhotoPicker = false
    @Published var showSettingsAlert = false
    @Published var alertMessage = "";
    
    var countImagesToRemove: Int {
        selectedImages.count(where: { $0.isSelected })
    }
    
    func chooseCamera() {
        sourceType = .camera
        showPhotoPicker = true
    }
    
    func chooseLibrary() {
        sourceType = .photoLibrary
        showPhotoPicker = true
    }
    
    func addImages(_ images: [UIImage]) {
        for image in images {
            selectedImages.append(SelectableImage(image: image))
        }
    }
    
    func addImage(_ image: UIImage) {
        selectedImages.append(SelectableImage(image: image))
    }
    
    func removeImages(_ images: [SelectableImage]) {
        for image in images {
            removeImage(image)
        }
    }
    
    func removeImage(_ image: SelectableImage){
        selectedImages.removeAll { selectableImage in
            image.id == selectableImage.id
        }
    }
    
    func saveToPhotoLibrary(_ index: Int) {
        if(!selectedImages.isEmpty && selectedImages.indices.contains(index)){
            UIImageWriteToSavedPhotosAlbum(selectedImages[index].image, nil, nil, nil)
        }
        else{
            
        }
    }
    
    func requestCameraPermission() async {
        resetPermissionVariables()
        let granted = await PermissionManager.requestCameraPermission()
        if granted {
            chooseCamera()
        } else {
            
            showSettingsAlert = true
            alertMessage = "To be able to take photos, please allow access to your photo library in settings."
        }
    }
    
    func requestPhotoLibraryPermission() {
        // Reset alert per trigger onChange
        resetPermissionVariables()
        PermissionManager.requestPhotoLibraryPermission { [weak self] status in
            guard let self else { return }
            switch status {
            case .authorized, .limited:
                self.chooseLibrary() //iOS Picker will manage authorizations automatically
            case .denied, .restricted:
                self.showSettingsAlert = true
                self.alertMessage = "To be able to select photos from library, please allow access to your photo library in settings."
                self.showPhotoPicker = false
                
            default:
                break
            }
        }
    }
    
    func resetPermissionVariables(){
        showPhotoPicker = false
        showSettingsAlert = false
        alertMessage = ""
    }
    
    func initSelectableImages(){
        selectedImages = selectedImages.map { img in
            var newImg = img
            newImg.isSelected = false
            return newImg
        }
    }
    
    func removeSelectedImages(){
        selectedImages.removeAll(where: { $0.isSelected })
    }
}
