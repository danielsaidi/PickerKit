//
//  ColorPickerBarScreen.swift
//  Demo
//
//  Created by Daniel Saidi on 2025-06-10.
//

import PickerKit
import SwiftUI

struct ColorPickerBarScreen: View {

    @State var axis: Axis = .horizontal
    @State var color: Color? = .yellow

    var body: some View {
        ZStack(alignment: .trailing) {
            color?.ignoresSafeArea()
            if axis == .vertical {
                colorPickerBar
            }
        }
        .safeAreaInset(edge: .bottom) {
            if axis == .horizontal {
                colorPickerBar
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Picker("Pick Axis", selection: $axis) {
                    Text("Horizontal").tag(Axis.horizontal)
                    Text("Vertical").tag(Axis.vertical)
                }
                .pickerStyle(.segmented)
            }
        }
        .navigationTitle("Color Picker Bar")
    }
}

private extension ColorPickerBarScreen {

    var colorPickerBar: some View {
        ColorPickerBar(
            selection: $color,
            axis: axis,
            colors: .standardColorPickerBarColors(withClearColor: true),
            resetValue: .pink,
            supportsOpacity: true
        )
        .padding(axis == .horizontal ? .leading : .horizontal, 10)
        .padding(.vertical)
        .background(.thinMaterial)
        .colorPickerBarStyle(.init(
            animation: .bouncy,
            spacing: 10,
            colorSize: 30,
            selectedColorSize: 45,
            resetButton: true
        ))
    }
}

#Preview {
    NavigationStack {
        ColorPickerBarScreen()
    }
}
