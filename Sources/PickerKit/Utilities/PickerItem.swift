//
//  PickerItem.swift
//  PickerKit
//
//  Created by Daniel Saidi on 2025-07-02.
//

import SwiftUI

/// This item view can be used to add a checkmark to content
/// views, based on a selection state.
public struct PickerItem<Content: View>: View {

    /// Create a picker item with a localized title.
    public init(
        _ title: LocalizedStringKey,
        titleBundle: Bundle = .main,
        isSelected: Bool
    ) where Content == Text {
        self.init(isSelected: isSelected) {
            Text(title, bundle: titleBundle)
        }
    }

    /// Create a picker item with a custom content view.
    public init(
        isSelected: Bool,
        content: @escaping () -> Content
    ) {
        self.isSelected = isSelected
        self.content = content
    }

    private let isSelected: Bool
    private let content: () -> Content

    public var body: some View {
        HStack {
            content()
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
            if isSelected {
                Image(systemName: "checkmark")
            }
        }
    }
}
