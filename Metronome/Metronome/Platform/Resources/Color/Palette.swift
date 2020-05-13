//
//  Palette.swift
//  MetronomeTests
//
//  Created by luca strazzullo on 5/5/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import SwiftUI

enum Palette: String {

    case blue
    case gray
    case green
    case orange
    case purple
    case yellow
    case black
    case white

    var color: Color {
        return Color(self.rawValue)
    }
}


extension Color {

    init(_ palette: Palette) {
        self = palette.color
    }
}
