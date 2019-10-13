//
//  HelpView.swift
//  Metronome
//
//  Created by luca strazzullo on 6/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI

struct HelpView: View {

    private let minimumTipWidth: CGFloat = 140

    @State var model: HelpViewModel
    @State var dismiss: () -> ()


    // MARK: Body

    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            Button(action: { self.model.prevTip() }) {
                Image(systemName: "arrow.left.circle.fill").font(.title).foregroundColor(.secondary)
            }
            GeometryReader { geometry in
                VStack(alignment: .center) {
                    HStack(alignment: .center, spacing: 40) {
                        Text(self.model.titleLabel).font(Font.system(.title))
                        Button(action: { self.dismiss() }) {
                            Image(systemName: "x.circle.fill").font(.title).foregroundColor(.primary)
                        }
                    }
                    HStack(alignment: .top, spacing: 25) {
                        ForEach(self.model.tips(for: self.numberOfVisibleTips(for: geometry)), id: \.self) { tipViewModel in
                            VStack(alignment: .center, spacing: 40) {
                                Image(tipViewModel.illustration).frame(width: 90, height: 90, alignment: .center)
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(tipViewModel.title).multilineTextAlignment(.leading).font(Font.system(.headline))
                                    Text(tipViewModel.description).multilineTextAlignment(.leading).font(Font.system(.callout))
                                }
                            }.frame(width: self.minimumTipWidth, height: nil, alignment: .center)
                        }.animation(.spring())
                    }.frame(width: nil, height: geometry.size.height / 10 * 7, alignment: .center)
                }
            }
            Button(action: { self.model.nextTip() }, label: {
                Image(systemName: "arrow.right.circle.fill").font(.title).foregroundColor(.secondary)
            })
        }
    }


    // MARK: Private helper methods

    private func numberOfVisibleTips(for geometry: GeometryProxy) -> Int {
        let minimumSize: CGFloat = minimumTipWidth
        return Int(floor(geometry.size.width / minimumSize))
    }
}
