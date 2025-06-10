//
//  DocumentScanner.swift
//  PickerKit
//
//  Created by Daniel Saidi on 2020-01-22.
//  Copyright © 2020-2025 Daniel Saidi. All rights reserved.
//

#if os(iOS)
import SwiftUI
import VisionKit

/// This document scanner can scan one or several pages of a
/// physical document.
///
/// ```swift
/// let camera = DocumentScanner(
///     isPresented: $isScannerPresented,
///     action: { result in ... }
/// )
/// ```
///
/// If you pass in an external `isPresented` state, the view
/// will automatically dismiss itself when it's done.
///
/// > Important: The view requires the following permissions:
/// `NSCameraUsageDescription`.
public struct DocumentScanner: UIViewControllerRepresentable {

    /// Create a document scanner.
    ///
    /// - Parameters:
    ///   - isPresented: An external presented state, if any.
    ///   - action: The action to use to handle the scan result.
    public init(
        isPresented: Binding<Bool>? = nil,
        action: @escaping ResultAction
    ) {
        self.isPresented = isPresented
        self.action = action
    }

    public typealias Result = CancellableResult<VNDocumentCameraScan>
    public typealias ResultAction = (Result) -> Void

    private let isPresented: Binding<Bool>?
    private let action: (Result) -> Void

    public func makeCoordinator() -> Coordinator {
        Coordinator(
            isPresented: isPresented,
            action: action
        )
    }
    
    public func makeUIViewController(
        context: Context
    ) -> VNDocumentCameraViewController {
        let controller = VNDocumentCameraViewController()
        controller.delegate = context.coordinator
        return controller
    }
    
    public func updateUIViewController(
        _ uiViewController: VNDocumentCameraViewController,
        context: Context
    ) {}
}

public extension DocumentScanner {

    class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate {
        
        public init(
            isPresented: Binding<Bool>?,
            action: @escaping DocumentScanner.ResultAction
        ) {
            self.isPresented = isPresented
            self.action = action
        }

        private let isPresented: Binding<Bool>?
        private let action: DocumentScanner.ResultAction

        public func documentCameraViewControllerDidCancel(
            _ controller: VNDocumentCameraViewController
        ) {
            action(.cancelled)
            tryDismiss()
        }
        
        public func documentCameraViewController(
            _ controller: VNDocumentCameraViewController,
            didFailWithError error: Error
        ) {
            action(.failure(error))
            tryDismiss()
        }
        
        public func documentCameraViewController(
            _ controller: VNDocumentCameraViewController,
            didFinishWith scan: VNDocumentCameraScan
        ) {
            action(.success(scan))
            tryDismiss()
        }

        public func tryDismiss() {
            isPresented?.wrappedValue = false
        }
    }
}

public extension VNDocumentCameraScan {

    /// Get all the images from the scan.
    var images: [UIImage] {
        (0..<pageCount).compactMap {
            imageOfPage(at: $0)
        }
    }
}

#Preview {
    struct Preview: View {

        @State var image: Image?
        @State var isPresented = false

        var body: some View {
            ImagePickerPreview(
                image: image,
                buttonTitle: "Scan Document",
                isPresented: $isPresented
            )
            .fullScreenCover(isPresented: $isPresented) {
                DocumentScanner(isPresented: $isPresented) { result in
                    switch result {
                    case .cancelled: print("Cancelled")
                    case .failure(let error): print(error)
                    case .success(let result): image = Image(uiImage: result.imageOfPage(at: 0))
                    }
                }
                .ignoresSafeArea()
            }
        }
    }

    return Preview()
}
#endif
