//
//  ImagePicker.swift
//  PickerKit
//
//  Created by Daniel Saidi on 2020-04-07.
//  Copyright © 2020-2025 Daniel Saidi. All rights reserved.
//

#if os(iOS)
import Photos
import SwiftUI
import UIKit

/// This image picker can be used to pick photos from Photos,
/// pick a photo with the camera, etc.
///
/// You can create this view with a result action as well as
/// an optional `isPresented` state, to make it auto-dismiss:
///
/// ```swift
/// let picker = ImagePicker(
///     sourceType: .photoAlbum,
///     isPresented: $isImagePickerPresented,       // Optional
///     cancelAction: { print("User did cancel") }, // Optional
///     resultAction: { result in ... })            // Mandatory
/// }
/// ```
///
/// This view uses a `UIImagePickerController` and registers
/// itself as the picker delegate.
public struct ImagePicker: UIViewControllerRepresentable {
    
    /// Create an image picker.
    ///
    /// - Parameters:
    ///   - sourceType: The image source type to pick.
    ///   - isPresented: An external presented state, if any.
    ///   - pickerConfig: A custom picker configuration, if any.
    ///   - cancelAction: The cancel action to trigger, if any.
    ///   - resultAction: The result action to trigger, if any.
    public init(
        sourceType: UIImagePickerController.SourceType,
        isPresented: Binding<Bool>? = nil,
        pickerConfig: @escaping PickerConfig = { _ in },
        cancelAction: @escaping CancelAction = {},
        resultAction: @escaping ResultAction
    ) {
        self.sourceType = sourceType
        self.isPresented = isPresented
        self.pickerConfig = pickerConfig
        self.cancelAction = cancelAction
        self.resultAction = resultAction
    }
    
    public typealias PickerConfig = (UIImagePickerController) -> Void
    public typealias PickerResult = Result<ImageRepresentable, Error>
    public typealias CancelAction = () -> Void
    public typealias ResultAction = (PickerResult) -> Void
    public typealias SourceType = UIImagePickerController.SourceType

    private let sourceType: UIImagePickerController.SourceType
    private let isPresented: Binding<Bool>?
    private let pickerConfig: PickerConfig
    private let cancelAction: CancelAction
    private let resultAction: ResultAction
        
    public func makeCoordinator() -> Coordinator {
        Coordinator(
            isPresented: isPresented,
            cancelAction: cancelAction,
            resultAction: resultAction
        )
    }

    public func makeUIViewController(context: Context) -> UIImagePickerController {
        let controller = UIImagePickerController()
        controller.sourceType = sourceType
        controller.delegate = context.coordinator
        pickerConfig(controller)
        return controller
    }

    public func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}

public extension ImagePicker {
    
    /// This enum defines ``ImagePicker``-specific errors.
    enum PickerError: Error {
        case missingPhotoLibraryPermissions
        case missingPickedImage
    }

    typealias ImageRepresentable = UIImage
}

public extension ImagePicker {

    /// Get all source types that work with the picker.
    static var allSourceTypes: [SourceType] {
        [.camera, .photoLibrary, .savedPhotosAlbum]
    }

    /// Get all source types that are enabled for the picker.
    static var availableSourceTypes: [SourceType] {
        allSourceTypes.filter(UIImagePickerController.isSourceTypeAvailable)
    }
}

public extension ImagePicker {
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

        public init(
            isPresented: Binding<Bool>?,
            cancelAction: @escaping ImagePicker.CancelAction,
            resultAction: @escaping ImagePicker.ResultAction
        ) {
            self.isPresented = isPresented
            self.cancelAction = cancelAction
            self.resultAction = resultAction
        }

        private let isPresented: Binding<Bool>?
        private let cancelAction: ImagePicker.CancelAction
        private let resultAction: ImagePicker.ResultAction

        public func imagePickerControllerDidCancel(
            _ picker: UIImagePickerController
        ) {
            cancelAction()
            tryDismissPicker()
        }
        
        public func imagePickerController(
            _ picker: UIImagePickerController,
            didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
        ) {
            if let image = info[.originalImage] as? UIImage {
                resultAction(.success(image))
            } else {
                let error = PickerError.missingPickedImage
                resultAction(.failure(error))
            }
            tryDismissPicker()
        }

        public func tryDismissPicker() {
            isPresented?.wrappedValue = false
        }
    }
}
#endif
