//
//  ChromeView.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 13/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI

struct ChromeView: View {

    var model: ChromeViewModel

    @State var helperIsPresented = false
    @State var helperDidAppear: () -> ()


    // MARK: Body

    var body: some View {
        VStack {
            Spacer()
            ZStack {
                HStack(alignment: .center, spacing: 24) {
                    Text(model.timeSignatureLabel).brandFont(.footnote)
                    Text(model.tempoLabel).brandFont(.footnote)
                    Spacer()
                    Button(action: { self.helperIsPresented = true }) {
                        Image(systemName: "questionmark.circle.fill").brandFont(.body)
                    }.sheet(isPresented: self.$helperIsPresented) {
                        TipsView(model: HelpViewModel(tips: TipsViewModelRepository.all), dismiss: {
                            self.helperIsPresented = false
                        }).onAppear(perform: self.helperDidAppear)
                    }
                }.foregroundColor(Color.white).opacity(0.7)
            }.frame(width: nil, height: 40, alignment: .center)
        }.padding([.leading, .trailing], 24).padding([.top, .bottom], 10)
    }
}


struct ChromeView_Previews: PreviewProvider {

    static var previews: some View {
        let configuration = MetronomeConfiguration(timeSignature: .default, tempo: .default)
        let viewModel = ChromeViewModel(configuration: configuration)

        return ChromeView(model: viewModel, helperDidAppear: {})
            .background(Color.black)
    }
}
