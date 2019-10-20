//
//  NSPointerArrayExtensions.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 18/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

extension NSPointerArray {

    func addObject(_ object: AnyObject?) {
        guard let strongObject = object else { return }

        let pointer = Unmanaged.passUnretained(strongObject).toOpaque()
        addPointer(pointer)
    }
}
