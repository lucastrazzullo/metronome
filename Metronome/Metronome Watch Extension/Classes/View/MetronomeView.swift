//
//  MetronomeView.swift
//  Metronome Watch WatchKit Extension
//
//  Created by luca strazzullo on 7/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI
import Combine

struct MetronomeView: View {

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    let model: MetronomeViewModel
    let metronome: Metronome


    // MARK: Body

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack(alignment: .center, spacing: 12) {
                Spacer()
                HStack(alignment: .center, spacing: 1) {
                    ForEach(model.beatViewModels, id: \.self) { beatViewModel in
                        BeatView(model: beatViewModel)
                    }
                }
                HStack(alignment: .center, spacing: 24) {
                    NavigationLink(destination: UpdateTimeSignatureView.with(metronome: metronome)) {
                        Text(model.timeSignatureLabel).font(Font.system(.footnote))
                    }
                    NavigationLink(destination: UpdateTempoView.with(metronome: metronome)) {
                        Text(model.tempoLabel).font(Font.system(.footnote))
                    }
                }.foregroundColor(Color.white.opacity(0.7))
                Button(action: { self.metronome.toggle() }, label: {
                    return Text(model.toggleLabel)
                })
            }
        }
    }
}
