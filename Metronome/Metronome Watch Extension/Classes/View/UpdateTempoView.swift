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

    @ObservedObject var metronome: ObservableMetronome<MetronomeViewModel>
    @State var selectedTempo: Int

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>


    // MARK: Body

    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Picker(selection: self.$selectedTempo, label:
                Text("BPM").padding(2)
            ) {
                ForEach(0 ..< Tempo.maximumBpm) {
                    Text("\($0)").font(.largeTitle)
                }
            }
            Button(action: {
                self.metronome.updateTempo(Tempo(bpm: self.selectedTempo))
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Confirm")
            })
        }
    }
}
