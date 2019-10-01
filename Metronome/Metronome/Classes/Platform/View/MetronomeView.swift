//
//  MetronomeView.swift
//  Metronome
//
//  Created by luca strazzullo on 30/9/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import UIKit
import SwiftUI

struct MetronomeView: View {

    var model: MetronomeViewModel


    // MARK: Body

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack(alignment: .center, spacing: 0) {
                Spacer()
                Text(model.tempoLabel).font(Font.system(.headline)).foregroundColor(Color.blue)
            }.padding([.bottom], 24)
            HStack(alignment: .center, spacing: 40) {
                ForEach(model.circles, id: \.self) { circle in
                    ZStack {
                        Text(String(circle)).font(Font.system(.caption)).foregroundColor(self.color(for: circle))
                        Circle().stroke(self.color(for: circle), lineWidth: self.lineWidth(for: circle))
                    }
                }
            }.padding([.trailing, .leading], 24)
        }
    }


    // MARK: Private helper methods

    private func color(for index: Int) -> Color {
        if let currentIndex = model.currentCircleIndex, currentIndex == index {
            return currentIndex == 0 ? Color.yellow : Color.blue
        } else {
            return Color.white.opacity(0.2)
        }
    }


    private func lineWidth(for index: Int) -> CGFloat {
        if let currentIndex = model.currentCircleIndex, currentIndex == index {
            return 2
        } else {
            return 1
        }
    }
}
