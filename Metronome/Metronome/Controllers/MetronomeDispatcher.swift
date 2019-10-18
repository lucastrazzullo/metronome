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


    func metronome(_ metronome: Metronome, didTick iteration: Int) {
        observers.allObjects.forEach({ ($0 as? MetronomeObserver)?.metronome(metronome, didTick: iteration) })
    }


    func metronome(_ metronome: Metronome, didStartAt iteration: Int) {
        observers.allObjects.forEach({ ($0 as? MetronomeObserver)?.metronome(metronome, didStartAt: iteration) })
    }


    func metronome(_ metronome: Metronome, didResetAt iteration: Int) {
        observers.allObjects.forEach({ ($0 as? MetronomeObserver)?.metronome(metronome, didResetAt: iteration) })
    }
}
