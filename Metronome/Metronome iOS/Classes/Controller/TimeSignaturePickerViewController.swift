//
//  TimeSignaturePickerViewController.swift
//  Metronome
//
//  Created by luca strazzullo on 2/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI

class TimeSignaturePickerViewController: UIHostingController<GesturePickerView> {

    init(viewModel: GesturePickerViewModel) {
        super.init(rootView: GesturePickerView(viewModel: viewModel))
    }


    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
