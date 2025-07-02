//
//  ForEachPicker.swift
//  SwiftUIKit
//
//  Created by Daniel Saidi on 2022-03-17.
//  Copyright © 2022-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This picker lists `Identifiable` values in a `ForEach`.
///
/// The picker supports both optional and non-optional value
/// binding. It will wrap the provided `content` view within
/// a regular button that applies the value when it's tapped.
public struct ForEachPicker<Value: Identifiable, Content: View>: View {

    /// Create a picker with an optional binding.
    ///
    /// - Parameters:
    ///   - selection: The selected value.
    ///   - values: The values to display.
    ///   - content: The list item content view.
    public init(
        selection: Binding<Value?>,
        values: [Value],
        content: @escaping (Value) -> Content
    ) {
        self.selection = selection
        self.values = values
        self.content = content
    }

    /// Create a picker with a non-optional binding.
    ///
    /// - Parameters:
    ///   - selection: The selected value.
    ///   - values: The values to display.
    ///   - content: The list item content view.
    public init(
        selection: Binding<Value>,
        values: [Value],
        content: @escaping (Value) -> Content
    ) {
        let optionalBinding: Binding<Value?> = .init(
            get: { selection.wrappedValue },
            set: {
                guard let new = $0 else { return }
                selection.wrappedValue = new
            }
        )
        self.init(
            selection: optionalBinding,
            values: values,
            content: content
        )
    }

    private var selection: Binding<Value?>
    private let values: [Value]
    private let content: (Value) -> Content

    public var body: some View {
        ForEach(values) { value in
            Button {
                selection.wrappedValue = value
            } label: {
                content(value)
            }
            .tint(.primary)
        }
    }
}

#Preview {

    struct Person: Equatable, Identifiable {

        let name: String

        var id: String { name }
    }

    struct Preview: View {

        @State var selection: Person?

        let persons: [Person] = [
            .init(name: "Daniel"),
            .init(name: "Johanna")
        ]

        var body: some View {
            List {
                ForEachPicker(
                    selection: $selection,
                    values: persons
                ) {
                    PickerItem($0.name, isSelected: $0 == selection)
                }
            }
        }
    }

    return Preview()
}
