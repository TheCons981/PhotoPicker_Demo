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
    @Published var selectedImages: [UIImage] = []

    @Published var showPhotoPicker = false
    @Published var showSettingsAlert = false
    @Published var alertMessage = "";
    
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
            selectedImages.append(image)
        }
    }
    
    func addImage(_ image: UIImage) {
        selectedImages.append(image)
    }
    
    func removeImage(_ index: Int){
        selectedImages.remove(at: index)
    }

    func saveToPhotoLibrary(_ index: Int) {
        if(!selectedImages.isEmpty && selectedImages.indices.contains(index)){
            UIImageWriteToSavedPhotosAlbum(selectedImages[index], nil, nil, nil)
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
}
