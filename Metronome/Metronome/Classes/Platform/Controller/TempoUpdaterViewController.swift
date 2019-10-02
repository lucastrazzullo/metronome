//
//  TempoUpdaterViewController.swift
//  Metronome
//
//  Created by luca strazzullo on 1/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI

class TempoUpdaterViewController: UIHostingController<TempoUpdaterView> {

    private var initialTempo: Tempo
    private(set) var tempo: Tempo


    // MARK: Object life cycle

    init(tempo: Tempo) {
        self.initialTempo = tempo
        self.tempo = tempo
        super.init(rootView: TempoUpdaterView(bpm: tempo.bpm))
    }


    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: Public methods

    func updateBpm(with offset: CGFloat) {
        if let newTempo = Tempo(bpm: initialTempo.bpm + (Int(offset)) / 8) {
            rootView.bpm = newTempo.bpm
            tempo = newTempo
        }
    }
}
