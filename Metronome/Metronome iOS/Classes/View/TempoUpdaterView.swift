//
//  TempoUpdaterView.swift
//  Metronome
//
//  Created by luca strazzullo on 1/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI

struct TempoUpdaterView: View {

    var bpm: Int

    var body: some View {
        ZStack {
            Color.yellow.edgesIgnoringSafeArea(.all)
            Text("\(bpm)BPM").font(Font.system(.largeTitle))
        }
    }
}
