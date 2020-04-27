//
//  UpdateTempoView.swift
//  Metronome Watch Extension
//
//  Created by luca strazzullo on 8/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI
import Combine

struct UpdateTempoView: View {

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State var selectedTempo: Int

    let metronome: Metronome


    // MARK: Object life cycle

    static func with(metronome: Metronome) -> UpdateTempoView {
        let tempo = metronome.configuration.tempo.bpm - Tempo.minimumBpm
        return UpdateTempoView(selectedTempo: tempo, metronome: metronome)
    }


    // MARK: Body

    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Picker(selection: self.$selectedTempo, label:
                Text("BPM").padding(2)
            ) {
                ForEach(Tempo.minimumBpm ..< Tempo.maximumBpm) {
                    Text("\($0)").font(.largeTitle)
                }
            }
            Button(action: {
                let bpm = self.selectedTempo + Tempo.minimumBpm
                self.metronome.configuration.setBpm(bpm)
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Confirm")
            })
        }
    }
}
