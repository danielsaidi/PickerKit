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



## Getting started

### Image Pickers

PickerKit has an ``ImagePicker``, a ``Camera``, and a ``DocumentScanner`` that can be used to "pick" images in various ways:

```swift
struct MyView: View {

    @State var image: Image?
    @State var isCameraPresented = false
    
    var body: some View {
        ScrollView {
            image?
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(.rect(cornerRadius: 10))
                .padding()  
        }
        .safeAreaInset(edge: .bottom) {
            Button("Take Photo") {
                isPresented.wrappedValue = true
            }
            .buttonStyle(.borderedProminent)
        }
        .fullScreenCover(isPresented: $isCameraPresented) {
            Camera(isPresented: $isCameraPresented) { result in
                switch result {
                case .failure(let error): print(error)
                case .success(let uiImage): image = Image(uiImage: uiImage)
                }
            }
            .ignoresSafeArea()
        }
    }
}
```

These pickers all work in the same way, and will call the result action with their unique result. If you pass in an `isPresented` binding, these pickers will automatically dismiss themselves when they're done.



## Repository

For more information, source code, etc., visit the [project repository](https://github.com/danielsaidi/PickerKit).



## License

PickerKit is available under the MIT license.



## Topics

### Images

- ``Camera``
- ``DocumentScanner``
- ``ImagePicker``



[Email]: mailto:daniel.saidi@gmail.com
[Website]: https://danielsaidi.com
[GitHub]: https://github.com/danielsaidi
[OpenSource]: https://danielsaidi.com/opensource
[Sponsors]: https://github.com/sponsors/danielsaidi
