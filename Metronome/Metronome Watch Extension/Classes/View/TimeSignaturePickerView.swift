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
        VStack(alignment: .center, spacing: 8) {
            HStack {
                Picker(selection: self.$viewModel.selectedBarLength,
                       label: Text(Copy.TimeSignature.barLength.localised).padding(2)) {
                    ForEach(viewModel.barLengthItems, id: \.position) { beat in
                        Text(String(beat.position + 1)).font(.title)
                    }
                }
                Picker(selection: self.$viewModel.selectedNoteLength,
                       label: Text(Copy.TimeSignature.noteLength.localised).padding(2)) {
                    ForEach(viewModel.noteLengthItems, id: \.self) { note in
                        Text(String(note.rawValue)).font(.title)
                    }
                }
            }
            Button(action: {
                self.viewModel.commit()
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Text(Copy.Controls.confirm.localised)
            })
        }
    }
}
