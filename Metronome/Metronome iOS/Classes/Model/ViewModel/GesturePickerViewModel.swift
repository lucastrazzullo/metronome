//
//  GesturePickerViewModel.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 7/5/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import Foundation

class GesturePickerViewModel: ObservableObject {

    @Published var heroLabel: String

    let backgroundColor: Palette
    let titleLabel: String
    let prefixLabel: String?
    let suffixLabel: String?


    // MARK: Object life cycle

    init(value: String, background: Palette, title: String, prefix: String?, suffix: String?) {
        heroLabel = value
        backgroundColor = background
        titleLabel = title
        prefixLabel = prefix
        suffixLabel = suffix
    }
}
