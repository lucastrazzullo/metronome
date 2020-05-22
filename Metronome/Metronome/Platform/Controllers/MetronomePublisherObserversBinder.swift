//
//  MetronomePublisherObserversBinder.swift
//  Metronome Cocoa iOS
//
//  Created by luca strazzullo on 19/5/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import Foundation

class MetronomePublisherObserversBinder {

    private let controllers: [MetronomeObserver]

    init(publisher: MetronomePublisher, controllers: [MetronomeObserver]) {
        self.controllers = controllers
        self.controllers.forEach { controller in
            controller.set(publisher: publisher)
        }
    }
}
