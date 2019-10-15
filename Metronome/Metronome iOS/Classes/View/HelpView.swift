//
//  HelpView.swift
//  Metronome
//
//  Created by luca strazzullo on 6/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI

struct HelpView: View {

    @State var model: HelpViewModel
    @State var dismiss: () -> ()


    // MARK: Body

    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            Button(action: { self.model.prevTip() }) {
                Image(systemName: "arrow.left.circle.fill")
                    .brandFont(.title1)
                    .foregroundColor(.secondary)
            }
            GeometryReader { geometry in
                VStack(alignment: .center) {
                    HStack(alignment: .center, spacing: 40) {
                        Text(self.model.titleLabel)
                            .brandFont(.title1)
                        Button(action: { self.dismiss() }) {
                            Image(systemName: "x.circle.fill")
                                .brandFont(.title1)
                                .foregroundColor(.primary)
                        }
                    }
                    HStack(alignment: .top, spacing: 24) {
                        ForEach(self.model.tips(for: self.numberOfVisibleTips(for: geometry, spacing: 24)), id: \.self) {
                            tipViewModel in
                            TipView(viewModel: tipViewModel).frame(width: TipView.idealWidth, height: nil, alignment: .center)
                        }.animation(.spring())
                    }.frame(width: nil, height: geometry.size.height / 10 * 7, alignment: .center)
                }
            }
            Button(action: { self.model.nextTip() }, label: {
                Image(systemName: "arrow.right.circle.fill")
                    .brandFont(.title1)
                    .foregroundColor(.secondary)
            })
        }.padding([.leading, .trailing], 24).padding([.top, .bottom], 10)
    }


    // MARK: Private helper methods

    private func numberOfVisibleTips(for geometry: GeometryProxy, spacing: CGFloat) -> Int {
        let minimumSize: CGFloat = TipView.idealWidth + spacing
        return Int(floor((geometry.size.width - spacing) / minimumSize))
    }
}
