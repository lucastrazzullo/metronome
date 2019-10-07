//
//  ColorExtensions.swift
//  Metronome
//
//  Created by luca strazzullo on 7/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI

extension Color {

    static var purple = Color(hex: "6236FF")
    static var orange = Color(hex: "FA6400")
    static var yellow = Color(hex: "F7B500")
    static var blue = Color(hex: "0091FF")


    init(hex: String) {
        var rgbValue: UInt64 = 0
        let scanner = Scanner(string: hex)
        scanner.scanHexInt64(&rgbValue)

        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff

        self.init(red: Double(r) / 0xff, green: Double(g) / 0xff, blue: Double(b) / 0xff)
    }
}
