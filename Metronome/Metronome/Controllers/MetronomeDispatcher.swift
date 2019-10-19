//
//  ObservableMetronome.swift
//  MetronomeTests
//
//  Created by luca strazzullo on 17/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

class MetronomeDispatcher {

    private var observers: NSPointerArray = NSPointerArray.weakObjects()


    // MARK: Object life cycle

    init(with metronome: Metronome) {
        metronome.delegate = self
    }


    // MARK: Public methods

    func addObserver(_ observer: MetronomeObserver) {
        guard observers.allObjects.firstIndex(where: { $0 is MetronomeObserver && ($0 as! MetronomeObserver) === observer }) == nil else { return }
        observers.addObject(observer)
    }
}


extension MetronomeDispatcher: MetronomeDelegate {

    func metronome(_ metronome: Metronome, didUpdate configuration: MetronomeConfiguration) {
        observers.allObjects.forEach({ ($0 as? MetronomeObserver)?.metronome(metronome, didUpdate: configuration) })
    }


    func metronome(_ metronome: Metronome, didPulse beat: MetronomeBeat) {
        observers.allObjects.forEach({ ($0 as? MetronomeObserver)?.metronome(metronome, didPulse: beat) })
    }


    func metronome(_ metronome: Metronome, willStartWithSuspended beat: MetronomeBeat?) {
        observers.allObjects.forEach({ ($0 as? MetronomeObserver)?.metronome(metronome, willStartWithSuspended: beat) })
    }


    func metronome(_ metronome: Metronome, willResetDuring beat: MetronomeBeat?) {
        observers.allObjects.forEach({ ($0 as? MetronomeObserver)?.metronome(metronome, willResetDuring: beat) })
    }
}
