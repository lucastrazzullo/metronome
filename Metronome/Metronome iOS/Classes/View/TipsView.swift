//
//  TipsView.swift
//  Metronome
//
//  Created by luca strazzullo on 6/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI

protocol TipsViewModel {
    var titleLabel: String { get }
    var tips: [TipViewModel] { get }

    func tips(with limitCount: Int) -> [TipViewModel]

    mutating func nextTip()
    mutating func prevTip()
}


struct TipsView: View {

    @State var model: TipsViewModel
    @State var dismiss: () -> ()


    // MARK: Body

    var body: some View {
        let gesture = DragGesture().onEnded {
            gesture in
            if gesture.translation.width < -100 {
                self.model.nextTip()
            } else if gesture.translation.width > 100 {
                self.model.prevTip()
            } else if gesture.translation.height > 100 {
                self.dismiss()
            }
        }

        return HStack(alignment: .center, spacing: 10) {
            ButtonView(icon: "arrow.left.circle.fill", action: { self.model.prevTip() })

            GeometryReader { geometry in
                VStack(alignment: .center, spacing: 20) {
                    TitleView(title: self.model.titleLabel, dismissIcon: "x.circle.fill", dismiss: self.dismiss)
                    TipsListView(tips: self.model.tips(with: self.numberOfVisibleTips(for: geometry, spacing: 30)), spacing: 30)
                }
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .top)
                .gesture(gesture)
            }

            ButtonView(icon: "arrow.right.circle.fill", action: { self.model.nextTip() })
        }.padding([.leading, .trailing], 12).padding([.top, .bottom], 10)
    }


    // MARK: Private helper methods

    private func numberOfVisibleTips(for geometry: GeometryProxy, spacing: CGFloat) -> Int {
        let minimumSize: CGFloat = TipView.minimumWidth + spacing
        return Int(floor((geometry.size.width - spacing) / minimumSize))
    }
}


private struct TipsListView: View {

    let tips: [TipViewModel]
    let spacing: CGFloat

    var body: some View {
        HStack(alignment: .top, spacing: spacing) {
            ForEach(tips, id: \.self) { tipViewModel in
                TipView(viewModel: tipViewModel)
                    .frame(width: TipView.minimumWidth, height: nil, alignment: .top)
            }.animation(.spring())
        }
    }
}


private struct ButtonView: View {

    let icon: String

    @State var action: () -> ()

    var body: some View {
        Button(action: { self.action() }) {
            Image(systemName: icon)
                .brandFont(.title1)
                .foregroundColor(.secondary)
        }
    }
}


private struct TitleView: View {

    let title: String
    let dismissIcon: String

    @State var dismiss: () -> ()

    var body: some View {
        HStack(alignment: .center, spacing: 40) {
            Text(title)
                .brandFont(.title1)
            Button(action: { self.dismiss() }) {
                Image(systemName: dismissIcon)
                    .brandFont(.title1)
                    .foregroundColor(.primary)
            }
        }.frame(width: nil, height: 60, alignment: .center)
    }
}
