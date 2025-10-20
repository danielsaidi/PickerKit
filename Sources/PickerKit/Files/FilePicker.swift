//
//  FilePicker.swift
//  PickerKit
//
//  Created by Daniel Saidi on 2020-04-07.
//  Copyright © 2020-2025 Daniel Saidi. All rights reserved.
//

#if os(iOS)
import SwiftUI
import UIKit
import UniformTypeIdentifiers

/// This file picker can be used to pick files from Files.
///
/// ```swift
/// let picker = FilePicker(
///     documentTypes: ["public.png"],
///     isPresented: $isFilePickerPresented,
///     action: { result in ... }
/// )
/// ```
///
/// If you pass in an `isPresented` binding, the view will automatically dismiss
/// itself when it's done.
///
/// The result contains a list of file urls that you can use in any way that you want.
public struct FilePicker: UIViewControllerRepresentable {
    
    /// Create a file picker.
    ///
    /// - Parameters:
    ///   - documentTypes: The uniform types to pick.
    ///   - isPresented: An external presented state, if any.
    ///   - pickerConfig: A custom picker configuration, if any.
    ///   - action: The action to use to handle the picker result.
    public init(
        documentTypes: [UTType],
        isPresented: Binding<Bool>? = nil,
        pickerConfig: @escaping PickerConfig = { _ in },
        action: @escaping ResultAction
    ) {
        self.documentTypes = documentTypes
        self.isPresented = isPresented
        self.pickerConfig = pickerConfig
        self.action = action
    }
    
    public typealias PickerConfig = (UIDocumentPickerViewController) -> Void
    public typealias Result = CancellableResult<[URL]>
    public typealias ResultAction = (Result) -> Void
    
    private let documentTypes: [UTType]
    private let isPresented: Binding<Bool>?
    private let pickerConfig: PickerConfig
    private let action: ResultAction

    public func makeCoordinator() -> Coordinator {
        .init(isPresented: isPresented, action: action)
    }

    public func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let controller = UIDocumentPickerViewController(forOpeningContentTypes: documentTypes)
        controller.delegate = context.coordinator
        pickerConfig(controller)
        return controller
    }

    public func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}
}

public extension FilePicker {

    /// This enum defines ``FilePicker``-specific errors.
    enum PickerError: Error {
        case noAvailableUrl
    }
}

public extension FilePicker {

    class Coordinator: NSObject, UINavigationControllerDelegate, UIDocumentPickerDelegate {

        public init(
            isPresented: Binding<Bool>?,
            action: @escaping FilePicker.ResultAction
        ) {
            self.isPresented = isPresented
            self.action = action
        }

        private let isPresented: Binding<Bool>?
        private let action: FilePicker.ResultAction

        public func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
            action(.cancelled)
        }
        
        public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            action(.success(urls))
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
                buttonTitle: "Pick Image File",
                isPresented: $isPresented
            )
            .fullScreenCover(isPresented: $isPresented) {
                FilePicker(
                    documentTypes: [.image],
                    isPresented: $isPresented
                ) { result in
                    switch result {
                    case .cancelled: print("Cancelled")
                    case .failure(let error): print(error)
                    case .success(let urls):
                        guard
                            let url = urls.first,
                            let data = try? Data(contentsOf: url),
                            let uiImage = UIImage(data: data)
                        else { return }
                        image = Image(uiImage: uiImage)
                    }
                }
                .ignoresSafeArea()
            }
        }
    }

    return Preview()
}
#endif
