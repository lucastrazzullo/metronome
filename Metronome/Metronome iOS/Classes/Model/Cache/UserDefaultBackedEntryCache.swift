//
//  UserDefaultBackedEntryCache.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 21/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

class UserDefaultBackedEntryCache: EntryCache {

    func value(for key: String) -> Any? {
        return UserDefaults.standard.value(forKey: key)
    }


    func set(value: Any?, for key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
}
