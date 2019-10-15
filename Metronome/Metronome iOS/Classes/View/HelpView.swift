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
                VStack(alignment: .center, spacing: 20) {

                    HStack(alignment: .center, spacing: 40) {
                        Text(self.model.titleLabel)
                            .brandFont(.title1)
                        Button(action: { self.dismiss() }) {
                            Image(systemName: "x.circle.fill")
                                .brandFont(.title1)
                                .foregroundColor(.primary)
                        }
                    }.frame(width: nil, height: 60, alignment: .center)

                    HStack(alignment: .top, spacing: 30) {
                        ForEach(self.model.tips(for: self.numberOfVisibleTips(for: geometry, spacing: 30)), id: \.self) {
                            tipViewModel in
                            TipView(viewModel: tipViewModel).frame(width: TipView.minimumWidth, height: nil, alignment: .top)
                        }.animation(.spring())
                    }

                }.frame(width: geometry.size.width, height: geometry.size.height, alignment: .top)
            }

            Button(action: { self.model.nextTip() }, label: {
                Image(systemName: "arrow.right.circle.fill")
                    .brandFont(.title1)
                    .foregroundColor(.secondary)
            })
        }.padding([.leading, .trailing], 12).padding([.top, .bottom], 10)
    }


    // MARK: Private helper methods

    private func numberOfVisibleTips(for geometry: GeometryProxy, spacing: CGFloat) -> Int {
        let minimumSize: CGFloat = TipView.minimumWidth + spacing
        return Int(floor((geometry.size.width - spacing) / minimumSize))
    }
}
