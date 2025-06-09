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
/// You can create this view with a result action as well as
/// an optional `isPresented` state, to make it auto-dismiss:
///
/// ```swift
/// let picker = Camera(
///     isPresented: $isCameraPresented,            // Optional
///     cancelAction: { print("User did cancel") }, // Optional
///     finishAction: { result in ... })            // Mandatory
/// }
/// ```
///
/// This view uses an ``ImagePicker`` with a `.camera` setup.
public struct Camera: View {

    /// Create a photo camera.
    ///
    /// - Parameters:
    ///   - isPresented: An external presented state, if any.
    ///   - cancelAction: The action to trigger when the operation is cancelled.
    ///   - resultAction: The action to trigger when the operation is completed.
    public init(
        isPresented: Binding<Bool>? = nil,
        cancelAction: @escaping ImagePicker.CancelAction = {},
        resultAction: @escaping ImagePicker.ResultAction
    ) {
        self.isPresented = isPresented
        self.cancelAction = cancelAction
        self.resultAction = resultAction
    }
    
    public typealias CameraResult = ImagePicker.PickerResult

    private let isPresented: Binding<Bool>?
    private let cancelAction: ImagePicker.CancelAction
    private let resultAction: ImagePicker.ResultAction
        
    public var body: some View {
        ImagePicker(
            sourceType: .camera,
            isPresented: isPresented,
            cancelAction: cancelAction,
            resultAction: resultAction
        )
    }
}

#Preview {
    struct MyView: View {

        @State var image: Image?
        @State var isCameraPresented = false

        var body: some View {
            VStack {
                image
                Button("Pick Image") {
                    isCameraPresented = true
                }
            }
            .fullScreenCover(isPresented: $isCameraPresented) {
                Camera(isPresented: $isCameraPresented) { result in
                    switch result {
                    case .failure(let error): print(error)
                    case .success(let uiImage): image = Image(uiImage: uiImage)
                    }
                }
            }
        }
    }

    return MyView()
}
#endif
