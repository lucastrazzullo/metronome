//
//  Cache.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 21/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

protocol EntryCache {
    func set(value: Any?, for key: String)
    func value(for key: String) -> Any?
}


class Cache {

    private(set) var entry: EntryCache


    // MARK: Object life cycle

    init(entry: EntryCache) {
        self.entry = entry
    }
}
