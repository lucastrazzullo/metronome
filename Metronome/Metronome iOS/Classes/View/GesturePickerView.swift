//
//  GesturePickerView.swift
//  Metronome
//
//  Created by luca strazzullo on 2/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI
import Combine

struct GesturePickerView: View {

    @ObservedObject private(set) var viewModel: GesturePickerViewModel

    var body: some View {
        ZStack {
            viewModel.backgroundColor.color.edgesIgnoringSafeArea(.all)
            ZStack(alignment: .center) {
                HStack(alignment: .center) {
                    Text(viewModel.titleLabel).brandFont(.headline)
                    Spacer()
                }
                HStack(alignment: .center, spacing: 4) {
                    Text(viewModel.prefixLabel ?? "").brandFont(.body)
                    Text(viewModel.heroLabel).brandFont(.largeTitle)
                    Text(viewModel.suffixLabel ?? "").brandFont(.body)
                }
            }
        }
    }
}
