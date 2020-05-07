//
//  Palette.swift
//  MetronomeTests
//
//  Created by luca strazzullo on 5/5/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import SwiftUI

protocol PaletteIdentifier {
    var name: String { get }
}


extension PaletteIdentifier where Self: RawRepresentable, Self.RawValue == String {

    var name: String {
        return self.rawValue
    }

    var color: Color {
        return Color(self.name)
    }
}

enum Palette: String, PaletteIdentifier {

    case blue
    case gray
    case green
    case orange
    case purple
    case yellow
    case black
    case white
}
