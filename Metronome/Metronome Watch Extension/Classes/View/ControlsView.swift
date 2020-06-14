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
        case tapTempo
        case beats
        case note
    }


    // MARK: Instance properties

    @ObservedObject private(set) var controlsViewModel: ControlsViewModel
    @ObservedObject private(set) var tapTempoViewModel: TapTempoPickerViewModel
    @ObservedObject private(set) var tempoViewModel: TempoPickerViewModel
    @ObservedObject private(set) var timeSignatureViewModel: TimeSignaturePickerViewModel

    @State private var activePicker: Picker = .tempo
    @State private var tapIndicatorHighlighted: Bool = false

    var body: some View {
        ZStack {
            GeometryReader { geometry in
                VStack(alignment: .center, spacing: 2) {
                    HStack(alignment: .center, spacing: 2) {
                        VStack(alignment: .center, spacing: 4) {
                            if self.activePicker == .tapTempo {
                                Spacer()
                            }

                            Circle()
                                .foregroundColor(self.tapIndicatorHighlighted ? Palette.green.color : Palette.white.color)
                                .frame(width: 8, height: 8, alignment: .center)

                            VStack(alignment: .center) {
                                Text(String(self.isActive(picker: .tapTempo) ? self.tapTempoViewModel.selectedTempoBpm ?? Int(self.tempoViewModel.selectedTempoBpm) : Int(self.tempoViewModel.selectedTempoBpm)))
                                    .minimumScaleFactor(0.1)
                                    .brandFont(.title)

                                Text(Copy.Tempo.unit.localised)
                                    .brandFont(.footnote)
                                    .opacity(0.75)
                            }

                            if self.activePicker == .tapTempo {
                                Spacer()
                                Button(action: { self.activePicker = .tempo }, label: {
                                    Text(Copy.Controls.done.localised)
                                })
                                .padding(4)
                            }
                        }
                        .frame(
                            width: self.activePicker == .tapTempo ? geometry.size.width : geometry.size.width / 2 - 1,
                            height: self.activePicker == .tapTempo ? geometry.size.height : geometry.size.height / 2 - 1)
                        .background(LinearGradient(self.isActive(picker: .tempo) ? Palette.Gradients.yellowGreen : self.isActive(picker: .tapTempo) ? Palette.Gradients.blueGreen : Palette.Gradients.gray))
                        .cornerRadius(8)
                        .onTapGesture {
                            self.tapIndicatorHighlighted.toggle()
                            if self.isActive(picker: .tempo) {
                                self.activePicker = .tapTempo
                            } else if self.isActive(picker: .tapTempo) {
                                self.tapTempoViewModel.update(with: Date().timeIntervalSinceReferenceDate)
                            } else {
                                self.activePicker = .tempo
                            }
                        }
                        .focusable(self.isActive(picker: .tempo))
                        .digitalCrownRotation(self.$tempoViewModel.selectedTempoBpm,
                                              from: Double(Tempo.range.lowerBound),
                                              through: Double(Tempo.range.upperBound),
                                              by: 1, sensitivity: .high,
                                              isContinuous: false, isHapticFeedbackEnabled: true)


                        VStack(alignment: .center) {
                            Image(SystemIcon.play).brandFont(.headline)
                        }
                        .frame(
                            width: self.activePicker == .tapTempo ? 0 : geometry.size.width / 2 - 1,
                            height: self.activePicker == .tapTempo ? 0 : geometry.size.height / 2 - 1)
                        .background(LinearGradient(self.controlsViewModel.metronomeIsRunning ? Palette.Gradients.blueGreen : Palette.Gradients.gray))
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
                        .frame(
                            width: self.activePicker == .tapTempo ? 0 : geometry.size.width / 2 - 1,
                            height: self.activePicker == .tapTempo ? 0 : geometry.size.height / 2 - 1)
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
                        .frame(
                            width: self.activePicker == .tapTempo ? 0 : geometry.size.width / 2 - 1,
                            height: self.activePicker == .tapTempo ? 0 : geometry.size.height / 2 - 1)
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
        .animation(.default)
    }


    // MARK: Private helper methods

    private func isActive(picker: Picker) -> Bool {
        return activePicker == picker && !self.controlsViewModel.metronomeIsRunning
    }
}


struct ControlsView_Previews: PreviewProvider {

    static var previews: some View {
        var configuration = MetronomeConfiguration.default
        configuration.setBpm(300)

        let controller = RemoteSessionController()
        controller.set(snapshot: MetronomeSession.Snapshot(owner: .watch, configuration: configuration, isSoundOn: false, isRunning: false, currentBeat: nil))

        let controlsViewModel = ControlsViewModel(controller: controller)
        let tempoViewModel = TempoPickerViewModel(controller: controller)
        let tapTempoViewModel = TapTempoPickerViewModel(controller: controller)
        let timeSignatureViewModel = TimeSignaturePickerViewModel(controller: controller)

        return ControlsView(controlsViewModel: controlsViewModel, tapTempoViewModel: tapTempoViewModel, tempoViewModel: tempoViewModel, timeSignatureViewModel: timeSignatureViewModel)
    }
}
