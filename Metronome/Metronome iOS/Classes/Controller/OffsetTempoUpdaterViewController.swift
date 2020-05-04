//
//  OffsetTempoUpdaterViewController.swift
//  Metronome
//
//  Created by luca strazzullo on 1/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI

class OffsetTempoUpdaterViewController: UIHostingController<GesturePickerView> {

    private var initialBpm: Int
    private(set) var bpm: Int


    // MARK: Object life cycle

    init(bpm: Int) {
        self.initialBpm = bpm
        self.bpm = bpm
        super.init(rootView: GesturePickerView(model: SlideTempoPickerViewModel(bpm: bpm)))
    }


    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: Public methods

    func updateBpm(with offset: Int) {
        bpm = initialBpm + offset
        rootView.model = SlideTempoPickerViewModel(bpm: bpm)
    }
}
