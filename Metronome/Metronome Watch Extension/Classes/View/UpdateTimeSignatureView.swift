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

    @ObservedObject var publisher: SnapshotMetronomePublisher<MetronomeViewModel>

    @State var selectedBarLengthIndex: Int
    @State var selectedNoteLengthIndex: Int

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>


    // MARK: Object life cycle

    static func build(with publisher: SnapshotMetronomePublisher<MetronomeViewModel>) -> UpdateTimeSignatureView {
        let selectedBarLengthIndex = publisher.snapshot.configuration.timeSignature.bits - TimeSignature.minimumBarLength
        let selectedNoteLengthIndex = TimeSignature.NoteLength.allCases.firstIndex(of: publisher.snapshot.configuration.timeSignature.noteLength) ?? 0
        return UpdateTimeSignatureView(publisher: publisher, selectedBarLengthIndex: selectedBarLengthIndex, selectedNoteLengthIndex: selectedNoteLengthIndex)
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
                self.publisher.metronome.configuration.setBarLength(self.selectedBarLengthIndex + TimeSignature.minimumBarLength)
                self.publisher.metronome.configuration.setNotLength(TimeSignature.NoteLength.allCases[self.selectedNoteLengthIndex])
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Confirm")
            })
        }
    }
}
