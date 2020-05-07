//
//  TapTempoPickerViewController.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 12/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI
import Combine

class TapTempoPickerViewController: UIHostingController<GesturePickerView> {

    private var cancellable: AnyCancellable?


    // MARK: Object life cycle

    init(pickerViewModel: TapTempoPickerViewModel) {
        let value = Copy.Picker.TapTempo.valuePlaceholder.localised
        let background = Palette.green
        let title = Copy.Picker.TapTempo.title.localised
        let suffix = Copy.Tempo.unit.localised
        let viewModel = GesturePickerViewModel(value: value, background: background, title: title, prefix: nil, suffix: suffix)
        super.init(rootView: GesturePickerView(viewModel: viewModel))

        cancellable = pickerViewModel.$selectedTempoBpm.sink { bpm in
            if let bpm = bpm {
                viewModel.heroLabel = String(bpm)
            } else {
                viewModel.heroLabel = Copy.Picker.TapTempo.valuePlaceholder.localised
            }
        }
    }


    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
