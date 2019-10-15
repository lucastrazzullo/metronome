//
//  MetronomeChromeView.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 13/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI

struct MetronomeChromeView: View {

    @ObservedObject var observed: ObservableMetronome<MetronomeViewModel>

    @State var helperIsPresented = false


    // MARK: Body

    var body: some View {
        VStack {
            Spacer()
            ZStack {
                HStack(alignment: .center, spacing: 24) {
                    Text(observed.snapshot.timeSignatureLabel).brandFont(.footnote)
                    Text(observed.snapshot.tempoLabel).brandFont(.footnote)
                    Spacer()
                    Button(action: { self.helperIsPresented = true }) {
                        Image(systemName: "questionmark.circle.fill").brandFont(.footnote)
                    }.sheet(isPresented: self.$helperIsPresented) {
                        HelpView(model: HelpViewModel(), dismiss: { self.helperIsPresented = false }).onAppear(perform: {
                            self.observed.reset()
                        })
                    }
                }.foregroundColor(Color.white).opacity(0.7).font(.body)
            }.frame(width: nil, height: 40, alignment: .center)
        }.padding([.leading, .trailing], 24).padding([.top, .bottom], 10)
    }
}
