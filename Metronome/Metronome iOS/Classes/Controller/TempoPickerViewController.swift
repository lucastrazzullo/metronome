//
//  TempoPickerViewController.swift
//  Metronome
//
//  Created by luca strazzullo on 1/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI

class TempoPickerViewController: UIHostingController<GesturePickerView> {

    init(viewModel: SlideTempoPickerViewModel) {
        super.init(rootView: GesturePickerView(viewModel: viewModel))
    }


    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
