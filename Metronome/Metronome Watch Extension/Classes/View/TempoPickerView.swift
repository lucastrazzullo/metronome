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

    @ObservedObject private(set) var viewModel: TempoPickerViewModel


    // MARK: Body

    var body: some View {
        ZStack(alignment: .top) {
            ZStack {
                Circle()
                    .trim(from: 0, to: trimPercentage(for: Tempo.range.upperBound))
                    .stroke(style: StrokeStyle(lineWidth: 6,
                                               lineCap: .round,
                                               lineJoin: .round))
                    .foregroundColor(Palette.gray.color)
                    .animation(.default)
                    .padding(8)

                Circle()
                    .trim(from: 0, to: trimPercentage(for: Int(viewModel.selectedTempoBpm)))
                    .stroke(style: StrokeStyle(lineWidth: 6,
                                               lineCap: .round,
                                               lineJoin: .round))
                    .foregroundColor(Palette.green.color)
                    .animation(.default)
                    .padding(8)

                VStack(alignment: .center) {
                    Text(String(Int(viewModel.selectedTempoBpm)))
                        .brandFont(.largeTitle)
                        .focusable(true)
                        .digitalCrownRotation($viewModel.selectedTempoBpm, from: Double(viewModel.tempoRange.lowerBound), through: Double(viewModel.tempoRange.upperBound), by: 1, sensitivity: .high, isContinuous: false, isHapticFeedbackEnabled: true)

                    Text(Copy.Tempo.unit.localised)
                        .font(.footnote)
                        .opacity(0.75)
                }
                .padding(.top, 12)
            }

            Text(Copy.Tempo.title.localised)
                .brandFont(.headline)
        }
    }


    // MARK: Private helper methodss

    private func trimPercentage(for tempo: Int) -> CGFloat {
        return CGFloat(Double(tempo) / Double(viewModel.tempoRange.upperBound - viewModel.tempoRange.lowerBound)) * 0.45
    }
}


struct TempoPickerView_Previews: PreviewProvider {

    static var previews: some View {
        let controller = RemoteSessionController()
        controller.set(configuration: .default)
        controller.set(tempoBpm: 120)
        let viewModel = TempoPickerViewModel(controller: controller)
        return TempoPickerView(viewModel: viewModel)
    }
}
