//
//  ChromeView.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 13/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI

struct ChromeView: View {

    @ObservedObject var viewModel: ControlsViewModel

    var body: some View {
        VStack {
            Spacer()
            ZStack {
                HStack(alignment: .center, spacing: 24) {
                    LeftControlsView(viewModel: viewModel)
                    Spacer()
                    RightControlsView(helperDidAppear: { self.viewModel.reset() })
                }.foregroundColor(Color.white).opacity(0.7)
            }.frame(width: nil, height: 40, alignment: .center)
        }.padding([.leading, .trailing], 24).padding([.top, .bottom], 10)
    }
}


struct LeftControlsView: View {

    @ObservedObject var viewModel: ControlsViewModel

    var body: some View {
        HStack(alignment: .center, spacing: 24) {
            Text(viewModel.timeSignatureLabel ?? "").brandFont(.footnote)
            Text(viewModel.tempoLabel ?? "").brandFont(.footnote)
        }
    }
}


struct RightControlsView: View {

    @State private var helperIsPresented = false

    let helperDidAppear: () -> ()

    var body: some View {
        Button(action: { self.helperIsPresented = true }) {
            Image(systemName: "questionmark.circle.fill").brandFont(.body)
        }.sheet(isPresented: self.$helperIsPresented) {
            TipsView(model: HelpViewModel(tips: TipsViewModelRepository.all), dismiss: {
                self.helperIsPresented = false
            }).onAppear(perform: self.helperDidAppear)
        }
    }
}
