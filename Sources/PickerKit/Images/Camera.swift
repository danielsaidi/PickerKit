//
//  Camera.swift
//  PickerKit
//
//  Created by Daniel Saidi on 2020-11-27.
//  Copyright © 2020-2025 Daniel Saidi. All rights reserved.
//

#if os(iOS)
import Photos
import SwiftUI

/// This camera picker can take images and return the result.
///
/// You can create this view with a result action and an optional `isPresented`:
///
/// ```swift
/// let picker = Camera(
///     isPresented: $isCameraPresented,
///     action: { result in ... })
/// }
/// ```
///
/// If you pass in an `isPresented` binding, the view will automatically dismiss
/// itself when it's done.
///
/// > Important: This view needs the `NSCameraUsageDescription` permission.
public struct Camera: View {

    /// Create a photo camera.
    ///
    /// - Parameters:
    ///   - isPresented: An external presented state, if any.
    ///   - action: The action to use to handle the camera result.
    public init(
        isPresented: Binding<Bool>? = nil,
        action: @escaping ImagePicker.ResultAction
    ) {
        self.isPresented = isPresented
        self.action = action
    }
    
    private let isPresented: Binding<Bool>?
    private let action: ImagePicker.ResultAction
        
    public var body: some View {
        ImagePicker(
            sourceType: .camera,
            isPresented: isPresented,
            action: action
        )
    }
}

#Preview {
    struct Preview: View {

        @State var image: Image?
        @State var isPresented = false

        var body: some View {
            ImagePickerPreview(
                image: image,
                buttonTitle: "Take Photo",
                isPresented: $isPresented
            )
            .fullScreenCover(isPresented: $isPresented) {
                Camera(isPresented: $isPresented) { result in
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

    return Preview()
}
#endif
