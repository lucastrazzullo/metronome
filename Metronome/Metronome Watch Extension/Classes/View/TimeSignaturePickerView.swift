//
//  UpdateTimeSignatureView.swift
//  Metronome Watch Extension
//
//  Created by luca strazzullo on 8/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI
import Combine

struct TimeSignaturePickerView: View {

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @ObservedObject private(set) var viewModel: TimeSignaturePickerViewModel


    // MARK: Body

    var body: some View {
        VStack(alignment: .center, spacing: 24) {
            Spacer()

            HStack(alignment: .center, spacing: 24) {
                VStack(alignment: .center, spacing: 2) {
                    PickerButton(icon: .plus, action: viewModel.increaseBarLength).frame(height: 24)
                    Text(String(viewModel.selectedBarLength)).brandFont(.title)
                    PickerButton(icon: .minus, action: viewModel.decreaseBarLength).frame(height: 24)
                }

                VStack(alignment: .center, spacing: 2) {
                    PickerButton(icon: .plus, action: viewModel.increaseNoteLength).frame(height: 24)
                    Text(String(viewModel.selectedNoteLength)).brandFont(.title)
                    PickerButton(icon: .minus, action: viewModel.decreaseNoteLength).frame(height: 24)
                }
            }

            Button(action: done) {
                Text(Copy.Controls.done.localised)
            }
            .buttonStyle(MetronomeButtonStyle(highlighted: true, background: .button4))
        }
    }


    // MARK: Private helper methods

    private func done() {
        viewModel.commit()
        presentationMode.wrappedValue.dismiss()
    }
}


struct TimeSignaturePickerView_Previews: PreviewProvider {

    static var previews: some View {
        let timeSignature = TimeSignature(barLength: TimeSignature.BarLength(numberOfBeats: 2), noteLength: .sixteenth)
        let configuration = MetronomeConfiguration(timeSignature: timeSignature, tempo: .default)
        let metronome = Metronome(with: configuration, soundOn: false)
        let viewModel = TimeSignaturePickerViewModel(metronome: metronome)
        return TimeSignaturePickerView(viewModel: viewModel)
    }
}
