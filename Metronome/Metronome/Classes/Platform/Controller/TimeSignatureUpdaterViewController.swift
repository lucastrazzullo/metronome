//
//  TimeSignatureUpdaterViewController.swift
//  Metronome
//
//  Created by luca strazzullo on 2/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI

class TimeSignatureUpdaterViewController: UIHostingController<BarLengthUpdaterView> {

    private var initialTimeSignature: TimeSignature
    private(set) var timeSignature: TimeSignature


    // MARK: Object life cycle

    init(timeSignature: TimeSignature) {
        self.initialTimeSignature = timeSignature
        self.timeSignature = timeSignature
        super.init(rootView: BarLengthUpdaterView(timeSignature: timeSignature))
    }


    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: Public methods

    func updateBarLength(with offset: Int) {
        if let newTimeSignature = TimeSignature(bits: initialTimeSignature.bits + (offset / 32), noteLength: initialTimeSignature.noteLength) {
            rootView.timeSignature = newTimeSignature
            timeSignature = newTimeSignature
        }
    }


    func updateNoteLength(with offset: Int) {
        let noteLengths = TimeSignature.NoteLength.allCases
        if let currentIndex = noteLengths.firstIndex(of: initialTimeSignature.noteLength), currentIndex + offset >= 0, currentIndex + offset < noteLengths.count , let newTimeSignature = TimeSignature(bits: initialTimeSignature.bits, noteLength: noteLengths[currentIndex + offset]) {
            rootView.timeSignature = newTimeSignature
            timeSignature = newTimeSignature
        }
    }
}
