//
//  ShapeIllustration.swift
//  Metronome CocoaTests
//
//  Created by luca strazzullo on 13/5/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import SwiftUI

enum ShapeIllustration: String {

    case button1 = "button-shape-1"
    case button2 = "button-shape-2"
    case button3 = "button-shape-3"
    case button4 = "button-shape-4"
    case button5 = "button-shape-5"
    case button6 = "button-shape-6"

    var name: String {
        return self.rawValue
    }
}


extension Image {

    init(_ shape: ShapeIllustration) {
        self = Image(shape.name)
    }
}
