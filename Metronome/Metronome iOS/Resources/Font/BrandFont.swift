//
//  BrandFont.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 15/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI

typealias BrandFontDescription = (String, CGFloat)

private var fontDescriptions: [UIFont.TextStyle: BrandFontDescription] = [
    .largeTitle: ("AmericanTypewriter", 88),
    .headline: ("AmericanTypewriter", 34),
    .title1: ("AmericanTypewriter", 26),
    .title2: ("AmericanTypewriter-Semibold", 16),
    .body: ("AmericanTypewriter", 16),
    .footnote: ("AmericanTypewriter", 14)
]


struct BrandFont: ViewModifier {
    @Environment(\.sizeCategory) var sizeCategory
    var description: BrandFontDescription

    func body(content: Content) -> some View {
       let scaledSize = UIFontMetrics.default.scaledValue(for: description.1)
        return content.font(.custom(description.0, size: scaledSize))
    }
}


extension View {
    func brandFont(_ style: UIFont.TextStyle) -> some View {
        let description = fontDescriptions[style]
        return self.modifier(BrandFont(description: description!))
    }
}
