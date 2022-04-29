//
//  ImagePicker.swift
//  Debug
//
//  Created by 이태현 on 2022/04/29.
//

import PhotosUI
import SwiftUI


struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?//바인딩을 설정하여 변경사항을 보낼 수 있음
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            guard let provider = results.first?.itemProvider else { return }
            
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    self.parent.image = image as? UIImage
                }
            }
        }//didFinishPicking은 갤러리에서 취소를 누르거나 사진을 선택했을때
    }
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator // viewController 와 SwiftUI 의 다리의 역할을 하는 delegate
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    
    typealias UIViewControllerType = PHPickerViewController
}
