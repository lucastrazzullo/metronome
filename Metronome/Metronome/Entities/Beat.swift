//
//  Beat.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 19/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

struct Beat {

    enum Intensity {
        case strong
        case normal
    }


    // MARK: Instance properties

    let intensity: Intensity
    let position: Int


    // MARK: Object builder

    static func with(tickIteration: Int) -> Beat {
        let position = tickIteration + 1

        if position == 1 {
            return Beat(intensity: .strong, position: position)
        } else {
            return Beat(intensity: .normal, position: position)
        }
    }
}


extension Beat: Equatable {}
