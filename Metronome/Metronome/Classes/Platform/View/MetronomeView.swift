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
    var toggleAction: (() -> ())?


    // MARK: Body

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            HStack(alignment: .center, spacing: 40) {
                ForEach(model.circles, id: \.self) { circle in
                    Circle().stroke(self.borderColor(for: circle), lineWidth: self.lineWidth(for: circle))
                }
                Button(model.toggleLabel, action: { self.toggleAction?() }).foregroundColor(Color.green).frame(width: 80, height: nil, alignment: .center)
            }.padding([.trailing, .leading], 24)
        }
    }


    // MARK: Private helper methods

    private func borderColor(for index: Int) -> Color {
        if let currentIndex = model.currentCircleIndex, currentIndex == index {
            return currentIndex == 0 ? Color.yellow : Color.blue
        } else {
            return Color.gray
        }
    }


    private func lineWidth(for index: Int) -> CGFloat {
        if let currentIndex = model.currentCircleIndex, currentIndex == index {
            return 6
        } else {
            return 4
        }
    }
}
