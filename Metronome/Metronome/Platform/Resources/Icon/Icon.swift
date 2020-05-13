//
//  SystemIcon.swift
//  MetronomeTests
//
//  Created by luca strazzullo on 8/5/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import Foundation

protocol IconIdentifier {
    var systemName: String { get }
}

extension IconIdentifier where Self: RawRepresentable, Self.RawValue == String {

    var systemName: String {
        return self.rawValue
    }
}

enum SystemIcon: String, IconIdentifier {
    case soundOn = "volume.3"
    case soundOff = "volume.slash"
}
