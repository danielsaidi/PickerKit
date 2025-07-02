import SwiftUI

public extension ColorPickerBar {

    @available(*, deprecated, renamed: "ColorPickerBar.Configuration")
    typealias Config = ColorPickerBar.Configuration
}

@available(*, deprecated, message: "Use ColorPickerBar init properties directly instead.")
public extension ColorPickerBar.Configuration {

    @available(*, deprecated, renamed: "init(barColors:resetValue:supportsOpacity:)")
    @_disfavoredOverload
    init(
        barColors: [Color] = .colorPickerBarColors,
        opacity: Bool = true,
        resetButton: Bool = false,
        resetValue: Color? = nil
    ) {
        self.barColors = barColors
        self.supportsOpacity = opacity
        self.resetValue = resetValue
    }

    @available(*, deprecated, renamed: "supportsOpacity")
    var opacity: Bool { supportsOpacity }
}

public extension Collection where Element == Color {

    @available(*, deprecated, renamed: "standardColorPickersBarColors")
    static var colorPickerBarColors: [Color] {
        [
            .black, .gray, .white,
            .red, .pink, .orange, .yellow,
            .indigo, .purple, .blue, .cyan, .teal, .mint,
            .green, .brown
        ]
    }

    @available(*, deprecated, renamed: "standardColorPickersBarColors")
    static func colorPickerBarColors(withClearColor: Bool) -> [Color] {
        let standard = colorPickerBarColors
        guard withClearColor else { return standard }
        return [.clear] + standard
    }
}

public extension View {

    @available(*, deprecated, renamed: "colorPickerBarConfiguration")
    func colorPickerBarConfig(
        _ config: ColorPickerBar.Configuration
    ) -> some View {
        self.colorPickerBarConfiguration(config)
    }
}
