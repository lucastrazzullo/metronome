//
//  ControlsView.swift
//  Metronome Watch Extension
//
//  Created by luca strazzullo on 6/5/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import SwiftUI

struct ControlsView: View {

    enum Picker {
        case tempo
        case beats
        case note
    }


    // MARK: Instance properties

    @ObservedObject private(set) var tempoViewModel: TempoPickerViewModel
    @ObservedObject private(set) var timeSignatureViewModel: TimeSignaturePickerViewModel

    @State private var activePicker: Picker = .tempo

    var body: some View {
        ZStack {
            GeometryReader { geometry in
                VStack(alignment: .center, spacing: 2) {
                    VStack(alignment: .center) {
                        Text(String(Int(self.tempoViewModel.selectedTempoBpm)))
                            .brandFont(.title)
                        Text(Copy.Tempo.unit.localised)
                            .brandFont(.footnote)
                            .opacity(0.75)
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height / 2 - 2)
                    .background(LinearGradient(self.activePicker == .tempo ? Palette.Gradients.greenBlue : Palette.Gradients.gray))
                    .cornerRadius(8)
                    .onTapGesture { self.activePicker = .tempo }
                    .focusable(self.activePicker == .tempo)
                    .digitalCrownRotation(self.$tempoViewModel.selectedTempoBpm,
                                          from: Double(Tempo.range.lowerBound),
                                          through: Double(Tempo.range.upperBound),
                                          by: 1, sensitivity: .high,
                                          isContinuous: false, isHapticFeedbackEnabled: true)

                    HStack(alignment: .center, spacing: 2) {
                        VStack {
                            Text(String(Int(self.timeSignatureViewModel.selectedBarLength)))
                                .brandFont(.title)
                            Text("beats")
                                .brandFont(.caption)
                                .opacity(0.75)
                        }
                        .frame(width: geometry.size.width / 2 - 1, height: geometry.size.height / 2 - 1)
                        .background(LinearGradient(self.activePicker == .beats ? Palette.Gradients.orangePink : Palette.Gradients.gray))
                        .cornerRadius(8)
                        .onTapGesture { self.activePicker = .beats }
                        .focusable(self.activePicker == .beats)
                        .digitalCrownRotation(self.$timeSignatureViewModel.selectedBarLength,
                                              from: Double(TimeSignature.BarLength.range.lowerBound),
                                              through: Double(TimeSignature.BarLength.range.upperBound),
                                              by: 1, sensitivity: .low,
                                              isContinuous: false, isHapticFeedbackEnabled: true)

                        VStack {
                            Text(String(self.timeSignatureViewModel.selectedNote.rawValue))
                                .brandFont(.title)
                            Text("note")
                                .brandFont(.caption)
                                .opacity(0.75)
                        }
                        .frame(width: geometry.size.width / 2 - 1, height: geometry.size.height / 2 - 1)
                        .background(LinearGradient(self.activePicker == .note ? Palette.Gradients.pinkOrange : Palette.Gradients.gray))
                        .cornerRadius(8)
                        .onTapGesture { self.activePicker = .note }
                        .focusable(self.activePicker == .note)
                        .digitalCrownRotation(self.$timeSignatureViewModel.selectedNoteIndex,
                                              from: 0,
                                              through: Double(self.timeSignatureViewModel.noteItems.count - 1),
                                              by: 1, sensitivity: .low,
                                              isContinuous: false, isHapticFeedbackEnabled: true)
                    }
                }
            }
        }
    }
}


struct ControlsView_Previews: PreviewProvider {

    static var previews: some View {
        let configuration = MetronomeConfiguration.default
        let controller = RemoteSessionController()
        controller.set(configuration: configuration)

        let tempoViewModel = TempoPickerViewModel(controller: controller)
        let timeSignatureViewModel = TimeSignaturePickerViewModel(controller: controller)

        return ControlsView(tempoViewModel: tempoViewModel, timeSignatureViewModel: timeSignatureViewModel)
    }
}
