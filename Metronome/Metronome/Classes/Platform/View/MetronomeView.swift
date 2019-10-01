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

    var toggleAction: (() -> ())?

    var bpm: Int
    var currentBit: Int?
    var isRunning: Bool = false

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            Text(String(currentBit ?? bpm)).font(Font.system(.largeTitle)).foregroundColor(Color.purple)
            HStack(alignment: .center, spacing: 0) {
                Spacer()
                Button(isRunning ? "Reset" : "Play", action: { self.toggleAction?() }).foregroundColor(Color.yellow).padding(.trailing, 20)
            }
        }
    }
}
