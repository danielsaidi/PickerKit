# ``PickerKit``

A SwiftUI library with various pickers, cameras, document scanners, etc.


## Overview

![PickerKit logo](Logo.png)

PickerKit is a SwiftUI library with various pickers, cameras, document scanners, etc.


## Installation

PickerKit can be installed with the Swift Package Manager:

```
https://github.com/danielsaidi/PickerKit.git
```



## Support My Work

You can [become a sponsor][Sponsors] to help me dedicate more time on my various [open-source tools][OpenSource]. Every contribution, no matter the size, makes a real difference in keeping these tools free and actively developed.



## Getting Started

### Colors

PickerKit has a ``ColorPickerBar`` that adds a color picker to a bar with additional colors.

The ``ColorPickerBar`` supports optional and non-optional bindings, and can be configured and styled to great extent.

### Images

PickerKit has an ``ImagePicker``, a ``Camera``, and a ``DocumentScanner`` that can be used to "pick" images in various ways.

These pickers all work in the same way, and will call the result action with their unique result. If you pass in an `isPresented` binding, these pickers will automatically dismiss themselves when they're done.



## Repository

For more information, source code, etc., visit the [project repository](https://github.com/danielsaidi/PickerKit).



## License

PickerKit is available under the MIT license.



## Topics

### Bindings

- ``OptionalBinding(_:_:)``

### Colors

- ``ColorPickerBar``

### Images

- ``Camera``
- ``DocumentScanner``
- ``ImagePicker``



[Email]: mailto:daniel.saidi@gmail.com
[Website]: https://danielsaidi.com
[GitHub]: https://github.com/danielsaidi
[OpenSource]: https://danielsaidi.com/opensource
[Sponsors]: https://github.com/sponsors/danielsaidi
