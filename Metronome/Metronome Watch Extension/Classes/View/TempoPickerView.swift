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
        ZStack(alignment: .bottom) {
            ZStack() {
                Circle()
                    .trim(from: 0, to: trimPercentage())
                    .stroke(style: StrokeStyle(lineWidth: 6,
                                               lineCap: .round,
                                               lineJoin: .round))
                    .foregroundColor(Palette.yellow.color)
                    .animation(.default)
                    .padding(8)

                VStack(alignment: .center) {
                    Text(String(Int(viewModel.selectedTempoBpm)))

                        .brandFont(.largeTitle)
                        .focusable(true)
                        .digitalCrownRotation($viewModel.selectedTempoBpm, from: Double(viewModel.tempoRange.lowerBound), through: Double(viewModel.tempoRange.upperBound), by: 1, sensitivity: .high, isContinuous: false, isHapticFeedbackEnabled: true)

                    Text(Copy.Tempo.unit.localised).font(.footnote)
                }
                .padding(.bottom, 24)
            }

            Button(action: viewModel.commit, label: {
                Text(Copy.Controls.done.localised)
            })
            .buttonStyle(ShapedButtonStyle(highlighted: true, shape: .button4))
        }
    }


    // MARK: Private helper methods

    private func done() {
        viewModel.commit()
        presentationMode.wrappedValue.dismiss()
    }


    private func trimPercentage() -> CGFloat {
        return CGFloat(viewModel.selectedTempoBpm / Double(viewModel.tempoRange.upperBound - viewModel.tempoRange.lowerBound))
    }
}


struct TempoPickerView_Previews: PreviewProvider {

    static var previews: some View {
        let controller = RemoteSessionController()
        controller.set(tempoBpm: 300)
        let viewModel = TempoPickerViewModel(controller: controller)
        return TempoPickerView(viewModel: viewModel)
    }
}
