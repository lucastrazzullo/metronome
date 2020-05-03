//
//  TimeSignatureUpdaterViewController.swift
//  Metronome
//
//  Created by luca strazzullo on 2/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI

class TimeSignatureUpdaterViewController: UIHostingController<GesturePickerView> {

    private var initialTimeSignature: TimeSignature
    private(set) var timeSignature: TimeSignature


    // MARK: Object life cycle

    init(timeSignature: TimeSignature) {
        self.initialTimeSignature = timeSignature
        self.timeSignature = timeSignature
        super.init(rootView: GesturePickerView(model: BarLengthPickerViewModel(timeSignature: timeSignature)))
    }


    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: Public methods

    func updateBarLength(with offset: Int) {
        timeSignature = TimeSignature(beats: initialTimeSignature.beats + (offset / 32), noteLength: initialTimeSignature.noteLength)
        rootView.model = BarLengthPickerViewModel(timeSignature: timeSignature)
    }


    func updateNoteLength(with offset: Int) {
        let noteLengths = TimeSignature.NoteLength.allCases
        if let currentIndex = noteLengths.firstIndex(of: initialTimeSignature.noteLength), currentIndex + offset >= 0, currentIndex + offset < noteLengths.count {
            timeSignature = TimeSignature(beats: initialTimeSignature.beats, noteLength: noteLengths[currentIndex + offset])
            rootView.model = NoteLengthPickerViewModel(timeSignature: timeSignature)
        }
    }
}
