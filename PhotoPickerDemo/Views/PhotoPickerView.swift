import SwiftUI
import Photos
import UIKit
import PhotosUI

struct PhotoPickerView: View {
    
    @EnvironmentObject var viewModel: PhotoPickerViewModel
    //var onImagePicked: (UIImage) -> Void
    
    @State private var showOptions = false
    @State private var showPhotoPicker = false
    @State private var showSettingsAlert = false
    @State private var showConfirmAlert = false
    @State private var selectedImages: [UIImage] = []
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 20) {
                    
                    ImagePreviewView(images: selectedImages)
                    
                    ImagePreviewButtonsView(images: selectedImages, showOptions: $showOptions, onImageRemoved: {
                        selectedImages = []
                    }, onImageAdded: {
                        viewModel.addImages(selectedImages)
                        viewModel.alertMessage = "Photo added to app grid!"
                        showConfirmAlert = true
                        selectedImages = []
                    })
                    
                    
                    
                }
                .confirmationDialog("Select source", isPresented: $showOptions) {
                    Button("Camera") {
                        Task { await viewModel.requestCameraPermission() }
                    }
                    Button("Library") {
                        viewModel.requestPhotoLibraryPermission()
                    }
                    Button("Cancel", role: .cancel) {}
                }
                
                
            }
            .toolbar(){
                PhotoPickerToolbar.toolbarItems(selectedImages: $selectedImages, showOptions: $showOptions, onImageRemoved: {
                    selectedImages = []
                }, onImageAdded:{
                    viewModel.addImages(selectedImages)
                    viewModel.alertMessage = "Photos added to app grid!"
                    showConfirmAlert = true
                    selectedImages = []
                })
                    
                ToolbarItem(placement: .principal){
                    Text("Photo Picker").bold().font(.title2)
                }
            }
            .sheet(isPresented: $showPhotoPicker) {
                if(viewModel.sourceType == .camera){
                    FullScreenPhotoTaker(
                        sourceType: viewModel.sourceType,
                        isPresented: $showPhotoPicker,
                        selectedImage: Binding(
                            get: { selectedImages.first },
                            set: {
                                if let image = $0 {
                                    selectedImages.append(image)
                                }
                                
                                /*if let image = $0 {
                                 onImagePicked(image)
                                 }*/
                            }
                        )
                    )
                    .edgesIgnoringSafeArea(.all)
                }
                else {
                    PhotoPicker(images: $selectedImages)
                }
                
            }
            
            // ViewModel → View
            .onChange(of: viewModel.showPhotoPicker) { _, newValue in
                showPhotoPicker = newValue
            }
            .onChange(of: viewModel.showSettingsAlert) { _, newValue in
                showSettingsAlert = newValue
            }
            
            // View → ViewModel
            .onChange(of: showPhotoPicker) { _, newValue in
                if viewModel.showPhotoPicker != newValue {
                    Task { @MainActor in viewModel.showPhotoPicker = newValue }
                }
            }
            .onChange(of: showSettingsAlert) { _, newValue in
                if viewModel.showSettingsAlert != newValue {
                    Task { @MainActor in viewModel.showSettingsAlert = newValue }
                }
            }
            // When leaving view
            .onDisappear(){
                showOptions = false
                showConfirmAlert = false
                viewModel.resetPermissionVariables()
            }
            
            // Alerts
            .alert("", isPresented: $showConfirmAlert) {
                Button("Ok", role: .cancel) {}
            } message: {
                Text(viewModel.alertMessage)
            }
            .alert("Permissions denied", isPresented: $showSettingsAlert) {
                Button("Open Settings") {
                    if let url = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(url)
                    }
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text(viewModel.alertMessage)
            }
            .padding()
        }
        .padding(0)
    }
    
}
