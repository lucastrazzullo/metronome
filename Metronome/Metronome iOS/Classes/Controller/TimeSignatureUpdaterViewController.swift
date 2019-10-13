//
//  TimeSignatureUpdaterViewController.swift
//  Metronome
//
//  Created by luca strazzullo on 2/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI

class TimeSignatureUpdaterViewController: UIHostingController<TimeSignatureUpdaterView> {

    private var initialTimeSignature: TimeSignature
    private(set) var timeSignature: TimeSignature


    // MARK: Object life cycle

    init(timeSignature: TimeSignature) {
        self.initialTimeSignature = timeSignature
        self.timeSignature = timeSignature
        super.init(rootView: TimeSignatureUpdaterView(model: TimeSignatureUpdaterViewModel(timeSignature: timeSignature)))
    }


    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: Public methods

    func updateBarLength(with offset: Int) {
        timeSignature = TimeSignature(bits: initialTimeSignature.bits + (offset / 32), noteLength: initialTimeSignature.noteLength)
        rootView.model.timeSignature = timeSignature
        rootView.backgroundColor = .orange
    }


    func updateNoteLength(with offset: Int) {
        let noteLengths = TimeSignature.NoteLength.allCases
        if let currentIndex = noteLengths.firstIndex(of: initialTimeSignature.noteLength), currentIndex + offset >= 0, currentIndex + offset < noteLengths.count {
            timeSignature = TimeSignature(bits: initialTimeSignature.bits, noteLength: noteLengths[currentIndex + offset])
            rootView.model.timeSignature = timeSignature
            rootView.backgroundColor = .purple
        }
    }
}
