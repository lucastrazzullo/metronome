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

    @State var viewModel: TimeSignaturePickerViewModel

    var completion: (TimeSignature) -> ()


    // MARK: Body

    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            HStack {
                Picker(selection: self.$viewModel.selectedBarLength,
                       label: Text(Copy.TimeSignature.barLength.localised).padding(2)) {
                    ForEach(viewModel.barLengthItems, id: \.self) { item in
                        Text(item.label).font(.title)
                    }
                }
                Picker(selection: self.$viewModel.selectedNoteLength,
                       label: Text(Copy.TimeSignature.noteLength.localised).padding(2)) {
                    ForEach(viewModel.noteLengthItems, id: \.self) { item in
                        Text(item.label).font(.title)
                    }
                }
            }
            Button(action: {
                let timeSignature: TimeSignature = {
                    let barLength = self.viewModel.selectedBarLength.length
                    let noteLength = TimeSignature.NoteLength(rawValue: self.viewModel.selectedNoteLength.length)
                    return TimeSignature(beats: barLength, noteLength: noteLength ?? .default)
                }()
                self.completion(timeSignature)
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Confirm")
            })
        }
    }
}
