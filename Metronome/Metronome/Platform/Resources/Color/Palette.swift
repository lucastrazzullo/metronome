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
    case pink
    case black
    case white

    var color: Color {
        return Color(self.rawValue)
    }


    enum Gradients {

        case blueGreen
        case greenBlue
        case yellowGreen
        case greenYellow
        case orangePink
        case pinkOrange
        case gray

        var colors: [Color] {
            switch self {
            case .blueGreen:
                return [Color("blueGreen-1"), Color("blueGreen-2")]
            case .greenBlue:
                return [Color("greenBlue-1"), Color("greenBlue-2")]
            case .yellowGreen:
                return [Color("yellowGreen-1"), Color("yellowGreen-2")]
            case .greenYellow:
                return [Color("greenYellow-1"), Color("greenYellow-2")]
            case .orangePink:
                return [Color("orangePink-1"), Color("orangePink-2")]
            case .pinkOrange:
                return [Color("pinkOrange-1"), Color("pinkOrange-2")]
            case .gray:
                return [Color("grayGray-1"), Color("grayGray-2")]
            }
        }
    }
}
