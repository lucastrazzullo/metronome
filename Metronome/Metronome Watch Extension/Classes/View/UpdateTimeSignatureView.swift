//
//  UpdateTimeSignatureView.swift
//  Metronome Watch Extension
//
//  Created by luca strazzullo on 8/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI
import Combine

struct UpdateTimeSignatureView: View {

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State var selectedBarLengthIndex: Int
    @State var selectedNoteLengthIndex: Int

    let metronome: Metronome


    // MARK: Object life cycle

    static func with(metronome: Metronome) -> UpdateTimeSignatureView {
        let barLengthIndex = metronome.configuration.timeSignature.beats - TimeSignature.minimumBarLength
        let noteLengthIndex = TimeSignature.NoteLength.allCases.firstIndex(of: metronome.configuration.timeSignature.noteLength) ?? 0

        return UpdateTimeSignatureView(selectedBarLengthIndex: barLengthIndex, selectedNoteLengthIndex: noteLengthIndex, metronome: metronome)
    }


    // MARK: Body

    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            HStack {
                Picker(selection: self.$selectedBarLengthIndex, label:
                    Text("Bar length").padding(2)
                ) {
                    ForEach(TimeSignature.minimumBarLength ..< TimeSignature.maximumBarLength + 1) {
                        Text("\($0)").font(.title)
                    }
                }
                Picker(selection: self.$selectedNoteLengthIndex, label:
                    Text("Note length").padding(2)
                ) {
                    ForEach(0 ..< TimeSignature.NoteLength.allCases.count) {
                        Text("\(TimeSignature.NoteLength.allCases[$0].rawValue)").font(.title)
                    }
                }
            }
            Button(action: {
                self.metronome.configuration.setBarLength(self.selectedBarLengthIndex + TimeSignature.minimumBarLength)
                self.metronome.configuration.setNotLength(TimeSignature.NoteLength.allCases[self.selectedNoteLengthIndex])
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Confirm")
            })
        }
    }
}
