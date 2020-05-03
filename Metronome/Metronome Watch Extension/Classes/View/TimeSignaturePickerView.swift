//
//  UpdateTimeSignatureView.swift
//  Metronome Watch Extension
//
//  Created by luca strazzullo on 8/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI
import Combine

class TimeSignaturePickerViewModel: ObservableObject {

    @Published var selectedBarLengthIndex: Int
    @Published var selectedNoteLengthIndex: Int

    var timeSignature: TimeSignature {
        let barLength = TimeSignature.minimumBarLength + selectedBarLengthIndex
        let noteLength = TimeSignature.NoteLength.allCases[selectedNoteLengthIndex]
        return TimeSignature(beats: barLength, noteLength: noteLength)
    }

    var barLengthItems: Range<Int> {
        return TimeSignature.minimumBarLength ..< TimeSignature.maximumBarLength + 1
    }

    var noteLengthItems: Range<Int> {
        return 0 ..< TimeSignature.NoteLength.allCases.count
    }


    init(timeSignature: TimeSignature) {
        selectedBarLengthIndex = timeSignature.beats - TimeSignature.minimumBarLength
        selectedNoteLengthIndex = TimeSignature.NoteLength.allCases.firstIndex(of: timeSignature.noteLength) ?? 0
    }
}


struct TimeSignaturePickerView: View {

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State var viewModel: TimeSignaturePickerViewModel
    @State var completion: (TimeSignature) -> ()


    // MARK: Body

    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            HStack {
                Picker(selection: self.$viewModel.selectedBarLengthIndex, label: Text("Bar length").padding(2)) {
                    ForEach(viewModel.barLengthItems) {
                        Text("\($0)").font(.title)
                    }
                }
                Picker(selection: self.$viewModel.selectedNoteLengthIndex, label: Text("Note length").padding(2)) {
                    ForEach(viewModel.noteLengthItems) {
                        Text("\(TimeSignature.NoteLength.allCases[$0].rawValue)").font(.title)
                    }
                }
            }
            Button(action: {
                self.completion(self.viewModel.timeSignature)
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Confirm")
            })
        }
    }
}
