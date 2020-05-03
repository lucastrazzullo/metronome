//
//  TempoPickerView.swift
//  Metronome Watch Extension
//
//  Created by luca strazzullo on 8/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI
import Combine

class TempoPickerViewModel: ObservableObject {

    @Published var selectedTempoIndex: Int

    var tempoItems: Range<Int> {
        return Tempo.minimumBpm ..< Tempo.maximumBpm
    }

    var tempo: Tempo {
        let bpm = selectedTempoIndex + Tempo.minimumBpm
        return Tempo(bpm: bpm)
    }


    init(tempo: Tempo) {
        selectedTempoIndex = tempo.bpm - Tempo.minimumBpm
    }
}


struct TempoPickerView: View {

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State var viewModel: TempoPickerViewModel
    @State var completion: ((Tempo) -> ())


    // MARK: Body

    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Picker(selection: self.$viewModel.selectedTempoIndex, label: Text("BPM").padding(2)) {
                ForEach(self.viewModel.tempoItems) {
                    Text("\($0)").font(.largeTitle)
                }
            }
            Button(action: {
                self.completion(self.viewModel.tempo)
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Confirm")
            })
        }
    }
}
