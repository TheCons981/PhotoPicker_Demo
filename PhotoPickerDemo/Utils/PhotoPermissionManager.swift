//
//  PhotoLibraryPermissionStatus.swift
//  PhotoPickerDemo
//
//  Created by Andrea Consorti on 13/06/25.
//

import Foundation
import Photos
import AVFoundation

class PermissionManager {
    
    static func requestPhotoLibraryPermission(completion: @escaping (PhotoLibraryPermissionStatus) -> Void) {
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
            DispatchQueue.main.async {
                switch status {
                case .authorized:
                    completion(.authorized)
                case .limited:
                    completion(.limited)
                case .denied:
                    completion(.denied)
                case .restricted:
                    completion(.restricted)
                case .notDetermined:
                    completion(.notDetermined)
                @unknown default:
                    completion(.denied)
                }
            }
        }
    }
    
    static func currentPhotoLibraryStatus() -> PhotoLibraryPermissionStatus {
        let status = PHPhotoLibrary.authorizationStatus(for: .readWrite)
        switch status {
        case .authorized:
            return .authorized
        case .limited:
            return .limited
        case .denied:
            return .denied
        case .restricted:
            return .restricted
        case .notDetermined:
            return .notDetermined
        @unknown default:
            return .denied
        }
    }
    
    static func requestCameraPermission() async -> Bool {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        if status == .authorized { return true }
        if status == .notDetermined {
            return await AVCaptureDevice.requestAccess(for: .video)
        }
        return false
    }
    
    
}

enum PhotoLibraryPermissionStatus {
    case authorized
    case limited
    case denied
    case restricted
    case notDetermined
}
