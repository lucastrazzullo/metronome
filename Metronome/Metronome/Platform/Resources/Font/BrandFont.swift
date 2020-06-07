//
//  BrandFont.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 15/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI

typealias BrandCustomFontDescription = (String, CGFloat)
typealias BrandSystemFontDescription = (CGFloat, Font.Weight)

private var customFontDescriptions: [Font.TextStyle: BrandCustomFontDescription] = [
    .largeTitle: ("FuturaPTCond-ExtraBold", 52),
    .headline: ("FuturaPTCond-ExtraBold", 20),
    .subheadline: ("FuturaPTCond-ExtraBold", 18)
]

private var systemFontDescription: [Font.TextStyle: BrandSystemFontDescription] = [
    .callout: (16, .regular),
    .footnote: (12, .regular),
    .title: (32, .bold),
    .body: (18, .regular),
    .caption: (10, .medium)
]


extension View {

    func brandFont(_ style: Font.TextStyle) -> some View {
        if let description = customFontDescriptions[style] {
            return AnyView(self.modifier(CustomFont(description: description)))
        } else {
            let description = systemFontDescription[style]
            let size = description?.0
            let weight = description?.1
            return AnyView(self.modifier(SystemFont(style: style, size: size, weight: weight)))
        }
    }
}


private struct CustomFont: ViewModifier {
    @Environment(\.sizeCategory) var sizeCategory
    var description: BrandCustomFontDescription

    func body(content: Content) -> some View {
        let scaledSize = UIFontMetrics.default.scaledValue(for: description.1)
        return content.font(.custom(description.0, size: scaledSize))
    }
}


private struct SystemFont: ViewModifier {
    @Environment(\.sizeCategory) var sizeCategory
    var style: Font.TextStyle
    var size: CGFloat?
    var weight: Font.Weight?

    func body(content: Content) -> some View {
        if let size = size, let weight = weight {
            let scaledSize = UIFontMetrics.default.scaledValue(for: size)
            return content.font(Font.system(size: scaledSize, weight: weight))
        } else if let size = size {
            let scaledSize = UIFontMetrics.default.scaledValue(for: size)
            return content.font(Font.system(size: scaledSize))
        } else {
            return content.font(Font.system(style))
        }
    }
}
