//
//  GesturePickerViewModel.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 5/5/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import Foundation
import Combine

class GesturePickerViewModel: ObservableObject {

    @Published var heroLabel: String

    var backgroundColor: Palette
    var titleLabel: String
    var prefixLabel: String?
    var suffixLabel: String?


    // MARK: Object life cycle

    init(value: String, background: Palette, title: String, prefix: String?, suffix: String?) {
        heroLabel = value
        backgroundColor = background
        titleLabel = title
        prefixLabel = prefix
        suffixLabel = suffix
    }
}
