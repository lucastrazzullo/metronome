//
//  UserDefaultBackedEntryCache.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 21/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

class UserDefaultBackedEntryCache: EntryCache {

    private let queue = DispatchQueue(label: "concurrent", attributes: .concurrent)


    // MARK: Public methods

    func value(for key: String) -> Any? {
        var result: Any?
        queue.sync {
            result = UserDefaults.standard.value(forKey: key)
        }
        return result
    }


    func set(value: Any?, for key: String) {
        queue.async(flags: .barrier) {
            UserDefaults.standard.set(value, forKey: key)
        }
    }
}
