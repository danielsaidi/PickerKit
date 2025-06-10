<p align="center">
    <img src="Resources/Icon.png" alt="Project Icon" width="250" />
</p>

<p align="center">
    <img src="https://img.shields.io/github/v/release/danielsaidi/PickerKit?color=%2300550&sort=semver" alt="Version" />
    <img src="https://img.shields.io/badge/swift-6.0-orange.svg" alt="Swift 6.0" />
    <a href="https://danielsaidi.github.io/PickerKit"><img src="https://img.shields.io/badge/documentation-web-blue.svg" alt="Documentation" /></a>
    <a href="https://github.com/danielsaidi/PickerKit/blob/master/LICENSE"><img src="https://img.shields.io/github/license/danielsaidi/PickerKit" alt="MIT License" /></a>
    <a href="https://github.com/sponsors/danielsaidi"><img src="https://img.shields.io/badge/sponsor-GitHub-red.svg" alt="Sponsor my work" /></a>
</p>


# PickerKit

PickerKit is a SwiftUI library with various pickers, cameras, document scanners, etc.



## Installation

PickerKit can be installed with the Swift Package Manager:

```
https://github.com/danielsaidi/PickerKit.git
```



## Support My Work

You can [become a sponsor][Sponsors] to help me dedicate more time on my various [open-source tools][OpenSource]. Every contribution, no matter the size, makes a real difference in keeping these tools free and actively developed.



## Getting Started

### Image Pickers

PickerKit has an `ImagePicker`, a `Camera`, and a `DocumentScanner` that can pick images:

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
        }
        .padding()
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



## Documentation

The online [documentation][Documentation] has more information, articles, code examples, etc.



## Demo Application

The `Demo` folder has a demo app that lets you test the library.



## Contact

Feel free to reach out if you have questions, or want to contribute in any way:

* Website: [danielsaidi.com][Website]
* E-mail: [daniel.saidi@gmail.com][Email]
* Bluesky: [@danielsaidi@bsky.social][Bluesky]
* Mastodon: [@danielsaidi@mastodon.social][Mastodon]



## License

PickerKit is available under the MIT license. See the [LICENSE][License] file for more info.



[Email]: mailto:daniel.saidi@gmail.com
[Website]: https://danielsaidi.com
[GitHub]: https://github.com/danielsaidi
[OpenSource]: https://danielsaidi.com/opensource
[Sponsors]: https://github.com/sponsors/danielsaidi

[Bluesky]: https://bsky.app/profile/danielsaidi.bsky.social
[Mastodon]: https://mastodon.social/@danielsaidi
[Twitter]: https://twitter.com/danielsaidi

[Documentation]: https://danielsaidi.github.io/PickerKit
[Getting-Started]: https://danielsaidi.github.io/PickerKit/documentation/Pickerkit/getting-started
[License]: https://github.com/danielsaidi/PickerKit/blob/master/LICENSE
