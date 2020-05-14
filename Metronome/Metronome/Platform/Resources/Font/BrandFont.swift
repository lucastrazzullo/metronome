//
//  BrandFont.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 15/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI

typealias BrandFontDescription = (String, CGFloat)

private var customFontDescriptions: [Font.TextStyle: BrandFontDescription] = [
    .largeTitle: ("FuturaPTCond-ExtraBold", 52),
    .headline: ("FuturaPTCond-ExtraBold", 20),
]

private var systemFontDescription: [Font.TextStyle: CGFloat] = [
    .callout: 16,
    .footnote: 12,
    .title: 32,
    .body: 18
]


struct CustomFont: ViewModifier {
    @Environment(\.sizeCategory) var sizeCategory
    var description: BrandFontDescription

    func body(content: Content) -> some View {
        let scaledSize = UIFontMetrics.default.scaledValue(for: description.1)
        return content.font(.custom(description.0, size: scaledSize))
    }
}


struct SystemFont: ViewModifier {
    @Environment(\.sizeCategory) var sizeCategory
    var style: Font.TextStyle
    var size: CGFloat?

    func body(content: Content) -> some View {
        if let size = size {
            let scaledSize = UIFontMetrics.default.scaledValue(for: size)
            return content.font(Font.system(size: scaledSize))
        } else {
            return content.font(Font.system(style))
        }
    }
}


extension View {

    func brandFont(_ style: Font.TextStyle) -> some View {
        if let description = customFontDescriptions[style] {
            return AnyView(self.modifier(CustomFont(description: description)))
        } else {
            let size = systemFontDescription[style]
            return AnyView(self.modifier(SystemFont(style: style, size: size)))
        }
    }
}
