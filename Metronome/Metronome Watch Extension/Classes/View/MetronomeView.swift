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

    @ObservedObject var publisher: SnapshotMetronomePublisher<MetronomeViewModel>

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>


    // MARK: Body

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack(alignment: .center, spacing: 12) {
                Spacer()
                HStack(alignment: .center, spacing: 1) {
                    ForEach(publisher.snapshot.beatViewModels, id: \.self) { beatViewModel in
                        BeatView(model: beatViewModel)
                    }
                }
                HStack(alignment: .center, spacing: 24) {
                    NavigationLink(destination: UpdateTimeSignatureView.build(with: publisher)) {
                        Text(publisher.snapshot.timeSignatureLabel).font(Font.system(.footnote))
                    }
                    NavigationLink(destination: UpdateTempoView.build(with: publisher)) {
                        Text(publisher.snapshot.tempoLabel).font(Font.system(.footnote))
                    }
                }.foregroundColor(Color.white.opacity(0.7))
                Button(action: { self.publisher.metronome.toggle() }, label: {
                    return Text(self.publisher.snapshot.toggleLabel)
                })
            }
        }
    }
}
