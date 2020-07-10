//
//  LinearGradientExtensions.swift
//  Metronome Cocoa
//
//  Created by luca strazzullo on 10/7/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import SwiftUI

extension LinearGradient {

    static func oblique(_ gradients: Palette.Gradients) -> LinearGradient {
        let gradient = Gradient(colors: gradients.colors)
        return LinearGradient(gradient: gradient, startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}
