//
//  TipsView.swift
//  Metronome
//
//  Created by luca strazzullo on 6/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI

struct TipsView: View {

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @ObservedObject private(set) var viewModel: TipsViewModel


    // MARK: Body

    var body: some View {
        let gesture = DragGesture().onEnded {
            gesture in
            if gesture.translation.width < -100 {
                self.viewModel.nextTip()
            } else if gesture.translation.width > 100 {
                self.viewModel.prevTip()
            }
        }

        return HStack(alignment: .center, spacing: 10) {
            ButtonView(icon: "arrow.left.circle.fill", action: { self.viewModel.prevTip() })

            VStack(alignment: .center, spacing: 20) {
                TitleView(title: viewModel.titleLabel, dismissIcon: "x.circle.fill", dismiss: {
                    self.presentationMode.wrappedValue.dismiss()
                })
                TipsListView(viewModel: viewModel).animation(.spring())
            }
            .gesture(gesture)

            ButtonView(icon: "arrow.right.circle.fill", action: { self.viewModel.nextTip() })
        }.padding([.leading, .trailing], 12).padding([.top, .bottom], 10)
    }
}


private struct TipsListView: View {

    @ObservedObject private(set) var viewModel: TipsViewModel

    var body: some View {
        GeometryReader { geometry in
            HStack(alignment: .top, spacing: 30) {
                ForEach(self.tips(for: geometry, spacing: 30), id: \.self) { tipViewModel in
                    TipView(viewModel: tipViewModel).frame(width: TipView.minimumWidth, height: nil, alignment: .top)
                }
            }
        }
    }


    // MARK: Private helper methods

    private func tips(for geometry: GeometryProxy, spacing: CGFloat) -> [TipViewModel] {
        let limitCount = numberOfVisibleTips(for: geometry, spacing: spacing)
        return Array(viewModel.tips[0..<limitCount])
    }


    private func numberOfVisibleTips(for geometry: GeometryProxy, spacing: CGFloat) -> Int {
        let minimumSize: CGFloat = TipView.minimumWidth + spacing
        return Int(floor((geometry.size.width - spacing) / minimumSize))
    }
}


private struct ButtonView: View {

    let icon: String
    let action: () -> ()

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
    let dismiss: () -> ()

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
