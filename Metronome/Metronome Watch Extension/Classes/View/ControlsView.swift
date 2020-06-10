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

    @ObservedObject private(set) var controlsViewModel: ControlsViewModel
    @ObservedObject private(set) var tempoViewModel: TempoPickerViewModel
    @ObservedObject private(set) var timeSignatureViewModel: TimeSignaturePickerViewModel

    @State private var activePicker: Picker = .tempo

    var body: some View {
        ZStack {
            GeometryReader { geometry in
                VStack(alignment: .center, spacing: 2) {
                    HStack(alignment: .center, spacing: 2) {
                        VStack(alignment: .center) {
                            Text(String(Int(self.tempoViewModel.selectedTempoBpm)))
                                .brandFont(.title)
                            Text(Copy.Tempo.unit.localised)
                                .brandFont(.footnote)
                                .opacity(0.75)
                        }
                        .frame(width: geometry.size.width / 2 - 1, height: geometry.size.height / 2 - 1)
                        .background(LinearGradient(self.isActive(picker: .tempo) ? Palette.Gradients.yellowGreen : Palette.Gradients.gray))
                        .cornerRadius(8)
                        .onTapGesture { self.activePicker = .tempo }
                        .focusable(self.isActive(picker: .tempo))
                        .digitalCrownRotation(self.$tempoViewModel.selectedTempoBpm,
                                              from: Double(Tempo.range.lowerBound),
                                              through: Double(Tempo.range.upperBound),
                                              by: 1, sensitivity: .high,
                                              isContinuous: false, isHapticFeedbackEnabled: true)


                        VStack(alignment: .center) {
                            Image(SystemIcon.play).brandFont(.title)
                        }
                        .frame(width: geometry.size.width / 2 - 1, height: geometry.size.height / 2 - 1)
                        .background(LinearGradient(self.controlsViewModel.metronomeIsRunning ? Palette.Gradients.greenBlue : Palette.Gradients.gray))
                        .cornerRadius(8)
                        .onTapGesture { self.controlsViewModel.toggleIsRunning() }
                    }

                    HStack(alignment: .center, spacing: 2) {
                        VStack {
                            Text(String(Int(self.timeSignatureViewModel.selectedBarLength)))
                                .brandFont(.title)
                            Text("beats")
                                .brandFont(.caption)
                                .opacity(0.75)
                        }
                        .frame(width: geometry.size.width / 2 - 1, height: geometry.size.height / 2 - 1)
                        .background(LinearGradient(self.isActive(picker: .beats) ? Palette.Gradients.orangePink : Palette.Gradients.gray))
                        .cornerRadius(8)
                        .onTapGesture { self.activePicker = .beats }
                        .focusable(self.isActive(picker: .beats))
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
                        .background(LinearGradient(self.isActive(picker: .note) ? Palette.Gradients.pinkOrange : Palette.Gradients.gray))
                        .cornerRadius(8)
                        .onTapGesture { self.activePicker = .note }
                        .focusable(self.isActive(picker: .note))
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


    // MARK: Private helper methods

    private func isActive(picker: Picker) -> Bool {
        return activePicker == picker && !self.controlsViewModel.metronomeIsRunning
    }
}


struct ControlsView_Previews: PreviewProvider {

    static var previews: some View {
        let configuration = MetronomeConfiguration.default
        let controller = RemoteSessionController()
        controller.set(configuration: configuration)
        controller.toggleIsRunning()

        let controlsViewModel = ControlsViewModel(controller: controller)
        let tempoViewModel = TempoPickerViewModel(controller: controller)
        let timeSignatureViewModel = TimeSignaturePickerViewModel(controller: controller)

        return ControlsView(controlsViewModel: controlsViewModel, tempoViewModel: tempoViewModel, timeSignatureViewModel: timeSignatureViewModel)
    }
}
