//
//  FullScreenPhotoTaker.swift
//  PhotoPickerDemo
//
//  Created by Andrea Consorti on 12/06/25.
//

import SwiftUI


struct FullScreenPhotoTaker: UIViewControllerRepresentable {
    var sourceType: UIImagePickerController.SourceType = .camera
    @Binding var isPresented: Bool
    @Binding var selectedImage: UIImage?

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UIViewController()
        controller.view.backgroundColor = .clear
        DispatchQueue.main.async {
            if context.coordinator.picker == nil {
                let picker = UIImagePickerController()
                picker.sourceType = sourceType
                picker.delegate = context.coordinator
                picker.modalPresentationStyle = .fullScreen
                context.coordinator.picker = picker
                controller.present(picker, animated: true)
            }
        }
        return controller
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // No update needed
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: FullScreenPhotoTaker
        weak var picker: UIImagePickerController?

        init(_ parent: FullScreenPhotoTaker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            picker.dismiss(animated: true) {
                self.parent.isPresented = false
            }
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true) {
                self.parent.isPresented = false
            }
        }
    }
}
