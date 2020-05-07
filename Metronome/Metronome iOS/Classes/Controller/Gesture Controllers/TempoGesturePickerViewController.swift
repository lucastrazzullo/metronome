//
//  TempoGesturePickerViewController.swift
//  Metronome
//
//  Created by luca strazzullo on 1/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI
import Combine

class TempoGesturePickerViewController: UIHostingController<GesturePickerView> {

    private var cancellable: AnyCancellable?


    // MARK: Object life cycle

    init(pickerViewModel: SlideTempoPickerViewModel) {
        let value = String(pickerViewModel.selectedTempoBpm)
        let background = Palette.yellow
        let title = Copy.Tempo.title.localised
        let suffix = Copy.Tempo.unit.localised
        let viewModel = GesturePickerViewModel(value: value, background: background, title: title, prefix: nil, suffix: suffix)
        super.init(rootView: GesturePickerView(viewModel: viewModel))

        cancellable = pickerViewModel.$selectedTempoBpm.sink { [weak viewModel] bpm in
            viewModel?.heroLabel = String(bpm)
        }
    }


    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
