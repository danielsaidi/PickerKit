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
/// ```swift
/// let picker = ImagePicker(
///     sourceType: .photoAlbum,
///     isPresented: $isPickerPresented, // Optional
///     pickerConfig: { picker in ... }, // Optional
///     action: { result in ... }        // Mandatory
/// )
/// ```
///
/// If you pass in an external `isPresented` state, the view
/// will automatically dismiss itself when it's done.
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
    ///   - action: The action to use to handle the picker result.
    public init(
        sourceType: UIImagePickerController.SourceType,
        isPresented: Binding<Bool>? = nil,
        pickerConfig: @escaping PickerConfig = { _ in },
        action: @escaping ResultAction
    ) {
        self.sourceType = sourceType
        self.isPresented = isPresented
        self.pickerConfig = pickerConfig
        self.action = action
    }
    
    public typealias PickerConfig = (UIImagePickerController) -> Void
    public typealias Result = ImagePickerResult<ImageRepresentable, ImagePicker.PickerError>
    public typealias ResultAction = (Result) -> Void
    public typealias SourceType = UIImagePickerController.SourceType

    private let sourceType: UIImagePickerController.SourceType
    private let isPresented: Binding<Bool>?
    private let pickerConfig: PickerConfig
    private let action: ResultAction
        
    public func makeCoordinator() -> Coordinator {
        .init(isPresented: isPresented, action: action)
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

/// This enum is used by all image pickers, even though they
/// may return different kinds of values.
public enum ImagePickerResult<Value, Error> {

    /// The operation was cancelled.
    case cancelled

    /// The operation failed.
    case failure(Error)

    /// The operation succeeded.
    case success(Value)
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
            action: @escaping ImagePicker.ResultAction
        ) {
            self.isPresented = isPresented
            self.action = action
        }

        private let isPresented: Binding<Bool>?
        private let action: ImagePicker.ResultAction

        public func imagePickerControllerDidCancel(
            _ picker: UIImagePickerController
        ) {
            action(.cancelled)
            tryDismissPicker()
        }
        
        public func imagePickerController(
            _ picker: UIImagePickerController,
            didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
        ) {
            if let image = info[.originalImage] as? UIImage {
                action(.success(image))
            } else {
                let error = PickerError.missingPickedImage
                action(.failure(error))
            }
            tryDismissPicker()
        }

        public func tryDismissPicker() {
            isPresented?.wrappedValue = false
        }
    }
}

struct ImagePickerPreview: View {

    let image: Image?
    let buttonTitle: String
    let isPresented: Binding<Bool>

    var body: some View {
        ScrollView {
            image?
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(.rect(cornerRadius: 10))
        }
        .padding()
        .safeAreaInset(edge: .bottom) {
            Button(buttonTitle) {
                isPresented.wrappedValue = true
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    struct MyView: View {

        @State var image: Image?
        @State var isPresented = false

        var body: some View {
            ImagePickerPreview(
                image: image,
                buttonTitle: "Pick Image",
                isPresented: $isPresented
            )
            .fullScreenCover(isPresented: $isPresented) {
                ImagePicker(
                    sourceType: .photoLibrary,
                    isPresented: $isPresented
                ) { result in
                    switch result {
                    case .cancelled: print("Cancelled")
                    case .failure(let error): print(error)
                    case .success(let uiImage): image = Image(uiImage: uiImage)
                    }
                }
                .ignoresSafeArea()
            }
        }
    }

    return MyView()
}
#endif
