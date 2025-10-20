# Release Notes

[PickerKit](https://github.com/danielsaidi/PickerKit) will use semver after 1.0.

Until then, breaking changes can happen in minor versions.



## 0.5

This version makes the SDK use Swift 6.1 and bumps the demo to Xcode 26.



## 0.4.2

### 💡 Adjustments

* `FontPickerFont` now conforms to `CustomFontRepresentable`.



## 0.4.1

### 💡 Adjustments

* `FontPickerFont` now conforms to `Codable`.



## 0.4

### ✨ Features

* `Font` has new `CustomFont`-based font builders.
* `FontPickerFont` has new `.openDyslexic` fonts.
* `FontPickerFont` has new `CustomFont`-based font builders.

### 📦 Package Changes

* `CustomFont` has been moved to https://github.com/danielsaidi/FontKit



## 0.3

### ✨ Features

* ``CustomFont`` can be used to handle custom fonts.



## 0.2

### ✨ Features

* ``ColorPickerBar`` has new configuration properties.
* ``ColorPickerBar.Style`` has a new `resetButton` property.
* ``FontPicker`` is a new `ForEach`-based font picker.
* ``FontPickerFont`` is a new multiplatform font representation.
* ``ForEachPicker`` is a new `ForEach`-based value picker.

### ✨ Multiplatform Features

* ``ColorRepresentable`` is a new multiplatform typealias.
* ``ImageRepresentable`` is a new multiplatform typealias.
* ``FontRepresentable`` is a new multiplatform typealias.

### 🗑️ Deprecations

* ``ColorPickerBar.Configuration`` is deprecated.



## 0.1.1

### ✨ Features

* ``ImagePicker`` has new source type properties.



## 0.1

This is the first public release of PickerKit.

### ✨ Features

* ``Camera`` can be used to take photos and handle them as images.
* ``ColorPickerBar`` adds a color picker to a horizontal or vertical bar with additional colors.
* ``DocumentScanner`` can be used to scan documents and handle them as images.
* ``FilePicker`` can be used to pick files from the Files app.
* ``ImagePicker`` can be used to pick images from the  photo library.
* ``MultiPicker`` can be used to pick multiple items in e.g. a list or form.
