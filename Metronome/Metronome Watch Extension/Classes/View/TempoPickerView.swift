//
//  TempoPickerView.swift
//  Metronome Watch Extension
//
//  Created by luca strazzullo on 8/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI
import Combine

struct TempoPickerView: View {

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @ObservedObject private(set) var viewModel: TempoPickerViewModel


    // MARK: Body

    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            Spacer()

            VStack(alignment: .center) {
                Text(String(Int(viewModel.selectedTempoBpm)))
                    .brandFont(.largeTitle)
                    .focusable(true)
                    .digitalCrownRotation($viewModel.selectedTempoBpm, from: Double(viewModel.tempoRange.lowerBound), through: Double(viewModel.tempoRange.upperBound), by: 1, sensitivity: .high, isContinuous: false, isHapticFeedbackEnabled: true)

                Text(Copy.Tempo.unit.localised).font(.footnote)
            }

            HStack(alignment: .center) {
                Spacer()
                Button(action: done) {
                    Text(Copy.Controls.done.localised)
                }
                .buttonStyle(ShapedButtonStyle(highlighted: true, shape: .button1))
                Spacer()
            }
        }
    }


    // MARK: Private helper methods

    private func done() {
        viewModel.commit()
        presentationMode.wrappedValue.dismiss()
    }
}
