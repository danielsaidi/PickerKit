//
//  FontPickerItem.swift
//  PickerKit
//
//  Created by Daniel Saidi on 2022-03-17.
//  Copyright © 2022-2026 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This view can be used to pick a ``FontPickerFont``.
///
/// This view will automatically apply the font and apply a `.tag` modifier for the
/// font value as well, for when you want to use it in a regular picker.
public struct FontPickerItem: View {
    
    public init(
        font: FontPickerFont,
        fontSize: CGFloat = 20,
        isSelected: Bool
    ) {
        self.font = font
        self.fontSize = fontSize
        self.isSelected = isSelected
    }
    
    private let font: FontPickerFont
    private let fontSize: CGFloat
    private let isSelected: Bool
    
    public var body: some View {
        PickerItem(
            font.displayName,
            isSelected: isSelected
        )
        .font(.dynamic(font, size: fontSize))
        .lineLimit(1)
        .tag(font)
    }
}
