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

    @ObservedObject var metronomeObserver: MetronomeObserver<MetronomeViewModel>

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>


    // MARK: Body

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack(alignment: .center, spacing: 12) {
                Spacer()
                HStack(alignment: .center, spacing: 1) {
                    ForEach(metronomeObserver.snapshot.bits, id: \.index) { bitViewModel in
                        ZStack {
                            self.backgroundColor(for: bitViewModel.index).edgesIgnoringSafeArea(.all)
                            Text(String(bitViewModel.label))
                                .font(Font.system(.title))
                                .foregroundColor(self.foregroundColor(forBitAt: bitViewModel.index))
                        }.cornerRadius(8)
                    }
                }
                HStack(alignment: .center, spacing: 24) {
                    NavigationLink(destination: UpdateTimeSignatureView.build(with: metronomeObserver)) {
                        Text(metronomeObserver.snapshot.timeSignatureLabel).font(Font.system(.footnote))
                    }
                    NavigationLink(destination: UpdateTempoView.build(with: metronomeObserver)) {
                        Text(metronomeObserver.snapshot.tempoLabel).font(Font.system(.footnote))
                    }
                }.foregroundColor(Color.white.opacity(0.7))
                Button(action: { self.metronomeObserver.metronome.toggle() }, label: {
                    return Text(self.metronomeObserver.snapshot.toggleLabel)
                })
            }
        }
    }


    // MARK: Private helper methods

    private func backgroundColor(for index: Int) -> Color {
        if metronomeObserver.snapshot.currentBitIndex == index {
            return Color.yellow
        } else {
            return Color.white.opacity(0.05)
        }
    }


    private func foregroundColor(forBitAt index: Int) -> Color {
        if metronomeObserver.snapshot.currentBitIndex == index {
            return Color.white
        } else {
            return Color.white.opacity(0.1)
        }
    }
}
