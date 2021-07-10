//
//  PHPickerView.swift
//  MyCamera
//
//  Created by terada enishi on 2021/07/11.
//

import SwiftUI
import PhotosUI

struct PHPickerView: UIViewControllerRepresentable {
    
    @Binding var isShowSheet: Bool
    
    @Binding var captureImage: UIImage?
    
    class Coordinator: NSObject,PHPickerViewControllerDelegate {
        var parent: PHPickerView
        
        init(_ parent: PHPickerView){
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            if let result = results.first{
                result.itemProvider.loadObject(ofClass: UIImage.self){
                    (image,error) in
                    if let unwrapImage = image as? UIImage{
                        self.parent.captureImage = unwrapImage
                    }
                }
                parent.isShowSheet = true
            }else{
                parent.isShowSheet = false
            }
            
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<PHPickerView>) -> PHPickerViewController{
       var configulation = PHPickerConfiguration()
        
        configulation.filter = .images
        
        configulation.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: configulation)
        
        picker.delegate = context.coordinator
        
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: UIViewControllerRepresentableContext<PHPickerView>) {
        
    }
}
