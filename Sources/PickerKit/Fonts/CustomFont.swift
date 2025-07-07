//
//  CustomFont.swift
//  PickerKit
//
//  Created by Daniel Saidi on 2022-07-11.
//  Copyright © 2022-2025 Kankoda. All rights reserved.
//

import SwiftUI

/// This struct can be used to load custom fonts from an app
/// or Swift Package.
public struct CustomFont: Sendable {

    /// Create a custom font from a file folder.
    ///
    /// - Parameters:
    ///   - name: The name of the file.
    ///   - family: The font family name, by default the first name segment.
    ///   - fileName: The font file name, by default `<name>.ttf`.
    ///   - bundle: The bundle in which the file is located.
    public init(
        name: String,
        family: String? = nil,
        fileName: String? = nil,
        bundle: Bundle = .main
    ) {
        self.name = name
        self.family = family ?? name.defaultFamily
        self.fileName = fileName ?? "\(name).ttf"
        self.bundle = bundle
    }

    public let name: String
    public let family: String
    public let fileName: String
    public let bundle: Bundle

    public func font(size: CGFloat) -> FontRepresentable {
        registerIfNeeded()
        guard let font = tryResolveFont(size: size) else {
            fatalError("Unable to initialize font '\(name)'")
        }
        return font
    }
}

private extension String {

    var defaultFamily: String {
        String(split(separator: "-").first ?? "")
    }
}

private extension CustomFont {

    var isRegistered: Bool {
        guard let url else { return false }
        #if os(macOS) && !targetEnvironment(macCatalyst)
        return CTFontManagerGetScopeForURL(url) == .none
        #else
        let names = UIFont.fontNames(forFamilyName: family)
        return names.contains(name)
        #endif
    }

    var url: CFURL? {
        bundle.url(
            forResource: fileName,
            withExtension: nil
        ) as CFURL?
    }

    func registerIfNeeded() {
        guard let url, !isRegistered else { return }
        CTFontManagerRegisterFontsForURL(url, .process, nil)
    }

    func tryResolveFont(size: Double) -> FontRepresentable? {
        FontRepresentable(name: name, size: size)
    }
}
