//
//  TimeSignaturePickerViewController.swift
//  Metronome
//
//  Created by luca strazzullo on 2/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI
import Combine

class TimeSignaturePickerViewController: UIHostingController<GesturePickerView> {

    private var cancellable: AnyCancellable?


    // MARK: Object life cycle

    init(pickerViewModel: BarLengthPickerViewModel) {
        let value = String(pickerViewModel.selectedTimeSignature.beats.count)
        let background = Palette.orange
        let title = Copy.TimeSignature.barLength.localised
        let suffix = String(format: Copy.TimeSignature.barLengthSuffixFormat.localised, pickerViewModel.selectedTimeSignature.noteLength.rawValue)
        let viewModel = GesturePickerViewModel(value: value, background: background, title: title, prefix: nil, suffix: suffix)
        super.init(rootView: GesturePickerView(viewModel: viewModel))

        cancellable = pickerViewModel.$selectedTimeSignature.sink { timeSignatre in
            viewModel.heroLabel = String(timeSignatre.beats.count)
        }
    }


    init(pickerViewModel: NoteLengthPickerViewModel) {
        let value = String(pickerViewModel.selectedTimeSignature.noteLength.rawValue)
        let background = Palette.purple
        let title = Copy.TimeSignature.noteLength.localised
        let prefix = String(format: Copy.TimeSignature.noteLengthPrefixFormat.localised, pickerViewModel.selectedTimeSignature.beats.count)
        let viewModel = GesturePickerViewModel(value: value, background: background, title: title, prefix: prefix, suffix: nil)
        super.init(rootView: GesturePickerView(viewModel: viewModel))

        cancellable = pickerViewModel.$selectedTimeSignature.sink { timeSignatre in
            viewModel.heroLabel = String(timeSignatre.noteLength.rawValue)
        }
    }


    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
