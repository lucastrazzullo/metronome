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
}


extension Beat: Equatable {}
