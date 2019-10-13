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
        HStack {
            Button(action: { self.model.prevTip() }) {
                Image(systemName: "arrow.left.circle.fill").font(.title).foregroundColor(.gray)
            }
            GeometryReader { geometry in
                VStack(alignment: .center, spacing: 40) {
                    HStack(alignment: .center, spacing: 40) {
                        Text(self.model.titleLabel).font(Font.system(.title))
                        Button(action: { self.dismiss() }) {
                            Image(systemName: "checkmark.circle.fill").font(.title).foregroundColor(.primary)
                        }
                    }
                    HStack(alignment: .top, spacing: 40) {
                        ForEach(self.model.tips, id: \.self) { tipViewModel in
                            VStack(alignment: .center, spacing: CGFloat(self.model.spacingBetweenTips)) {
                                Image(tipViewModel.illustration).frame(width: 90, height: 90, alignment: .center)
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(tipViewModel.title).multilineTextAlignment(.leading).font(Font.system(.headline))
                                    Text(tipViewModel.description).multilineTextAlignment(.leading).font(Font.system(.callout))
                                }
                            }.frame(width: self.width(for: tipViewModel, geometry: geometry), height: nil, alignment: .center)
                        }.animation(.spring())
                    }
                }
            }
            Button(action: { self.model.nextTip() }, label: {
                Image(systemName: "arrow.right.circle.fill").font(.title).foregroundColor(.gray)
            })
        }
    }


    // MARK: Private helper methods

    private func width(for tipViewModel: TipViewModel, geometry: GeometryProxy) -> CGFloat {
        return (geometry.size.width / CGFloat(model.numberOfVisibleTips)) - CGFloat(model.spacingBetweenTips)
    }
}
