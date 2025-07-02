# Release Notes

PickerKit will use semver after 1.0. 

Until then, breaking changes can happen in minor versions.



## 0.2

### ✨ Features

* ``ColorPickerBar`` takes bar colors, reset value and supports opacity directly.
* ``ColorPickerBar.Style`` is the new owner of the `resetButton` property.
* ``ColorRepresentable`` is a new typealias for platform-specific color types.
* ``ImageRepresentable`` is a new typealias for platform-specific image types.
* ``FontRepresentable`` is a new typealias for platform-specific font types.

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
