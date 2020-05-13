//
//  SystemIcon.swift
//  MetronomeTests
//
//  Created by luca strazzullo on 8/5/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import SwiftUI

enum SystemIcon: String {

    case soundOn = "volume.3"
    case soundOff = "volume.slash"
    case arrowDown = "chevron.compact.down"
    case on = "checkmark.square.fill"
    case off = "xmark.square.fill"

    var name: String {
        return self.rawValue
    }
}


extension Image {

    init(_ icon: SystemIcon) {
        self = Image(systemName: icon.name)
    }
}
