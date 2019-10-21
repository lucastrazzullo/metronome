//
//  WelcomeCache.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 21/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

class WelcomeCache: Cache {

    enum Key: String {
        case hasBeenPresented = "hasWelcomeBeenPresented"
    }


    // MARK: Instance properties

    var hasBeenPresented: Bool? {
        get {
            return entry.value(for: Key.hasBeenPresented.rawValue) as? Bool
        }
        set {
            entry.set(value: newValue, for: Key.hasBeenPresented.rawValue)
        }
    }
}
