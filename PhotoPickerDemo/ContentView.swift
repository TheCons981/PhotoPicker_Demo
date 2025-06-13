//
//  ContentView.swift
//  PhotoPickerDemo
//
//  Created by Andrea Consorti on 11/06/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @StateObject var pickerViewModel = PhotoPickerViewModel()
    //@State private var finalImage: UIImage?
    
    
    var body: some View {
        NavigationStack {
            TabView {
                
                //Photo picker
                PhotoPickerView()
                    .environmentObject(pickerViewModel)
                    .tabItem {
                        Label("Photo Picker", systemImage: "photo.on.rectangle")
                    }
                    
                
                // Grid for dhowing selected photos from photo picker
                PhotosGridView()
                    .environmentObject(pickerViewModel)
                    .tabItem {
                        Label("Selected Photos", systemImage: "square.grid.2x2")
                    }
                    
            }
            .toolbar(.hidden)
        }
        
    }
    
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
