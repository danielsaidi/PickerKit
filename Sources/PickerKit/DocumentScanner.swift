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
/// You can create this view with a result action as well as
/// an optional `isPresented` state, to make it auto-dismiss:
///
/// ```swift
/// let camera = DocumentScanner(
///     isPresented: $isScannerPresented,           // Optional
///     cancelAction: { print("User did cancel") }  // Optional
///     resultAction: { result in ... }             // Mandatory
/// }
/// ```
///
/// This picker uses a `VNDocumentCameraViewController` that
/// will return a `VNDocumentCameraScan` with all scan pages.
public struct DocumentScanner: UIViewControllerRepresentable {

    /// Create a document scanner.
    ///
    /// - Parameters:
    ///   - isPresented: An external presented state, if any.
    ///   - cancelAction: The action to trigger when the scan is cancelled.
    ///   - resultAction: The action to trigger when the scan is completed.
    public init(
        isPresented: Binding<Bool>? = nil,
        cancelAction: @escaping CancelAction = {},
        resultAction: @escaping ResultAction
    ) {
        self.isPresented = isPresented
        self.cancelAction = cancelAction
        self.resultAction = resultAction
    }
    
    public typealias CameraResult = Result<VNDocumentCameraScan, Error>
    public typealias CancelAction = () -> Void
    public typealias ResultAction = (CameraResult) -> Void

    private let isPresented: Binding<Bool>?
    private let cancelAction: CancelAction
    private let resultAction: ResultAction
        
    public func makeCoordinator() -> Coordinator {
        Coordinator(
            isPresented: isPresented,
            cancelAction: cancelAction,
            resultAction: resultAction
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
            cancelAction: @escaping DocumentScanner.CancelAction,
            resultAction: @escaping DocumentScanner.ResultAction
        ) {
            self.isPresented = isPresented
            self.cancelAction = cancelAction
            self.resultAction = resultAction
        }

        private let isPresented: Binding<Bool>?
        private let cancelAction: DocumentScanner.CancelAction
        private let resultAction: DocumentScanner.ResultAction

        public func documentCameraViewControllerDidCancel(
            _ controller: VNDocumentCameraViewController
        ) {
            cancelAction()
        }
        
        public func documentCameraViewController(
            _ controller: VNDocumentCameraViewController,
            didFailWithError error: Error
        ) {
            resultAction(.failure(error))
        }
        
        public func documentCameraViewController(
            _ controller: VNDocumentCameraViewController,
            didFinishWith scan: VNDocumentCameraScan
        ) {
            resultAction(.success(scan))
        }

        public func tryDismissPicker() {
            isPresented?.wrappedValue = false
        }
    }
}
#endif
