//
//  TapTempoPickerViewController.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 12/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI

class TapTempoPickerViewController: UIHostingController<GesturePickerView> {

    init(viewModel: TapTempoPickerViewModel) {
        super.init(rootView: GesturePickerView(viewModel: viewModel))
    }


    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
