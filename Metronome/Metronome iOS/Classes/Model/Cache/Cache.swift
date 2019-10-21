//
//  Cache.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 21/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

class Cache {

    private(set) var entry: EntryCache


    // MARK: Object life cycle

    init(entry: EntryCache) {
        self.entry = entry
    }
}
