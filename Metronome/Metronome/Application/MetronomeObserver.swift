//
//  MetronomeObserver.swift
//  Metronome Cocoa iOS
//
//  Created by luca strazzullo on 19/5/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import Foundation

protocol MetronomeController {
    func set(publisher: MetronomePublisher)
}


class MetronomeObserver {

    private let controllers: [MetronomeController]

    init(publisher: MetronomePublisher, controllers: [MetronomeController]) {
        self.controllers = controllers
        self.controllers.forEach { controller in
            controller.set(publisher: publisher)
        }
    }
}
