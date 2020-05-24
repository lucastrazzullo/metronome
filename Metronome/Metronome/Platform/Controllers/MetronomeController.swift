//
//  MetronomeController.swift
//  Metronome CocoaTests
//
//  Created by luca strazzullo on 22/5/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import Foundation

protocol MetronomeController: AnyObject {

    var session: MetronomeSession { get }

    func start()
    func reset()
    func toggleIsRunning()
    func toggleIsSoundOn()
    
    func set(configuration: MetronomeConfiguration)

    func set(timeSignature: TimeSignature)
    func set(isAccent: Bool, forBeatAt position: Int)

    func set(tempo: Tempo)
    func set(tempoBpm: Int)
}
