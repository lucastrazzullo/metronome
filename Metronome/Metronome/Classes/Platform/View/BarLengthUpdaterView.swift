//
//  BarLengthUpdaterView.swift
//  Metronome
//
//  Created by luca strazzullo on 2/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI

struct BarLengthUpdaterView: View {

    var timeSignature: TimeSignature

    var body: some View {
        ZStack {
            Color.purple.edgesIgnoringSafeArea(.all)
            Text("\(timeSignature.bits)/\(timeSignature.noteLength.rawValue)").font(Font.system(.largeTitle))
        }
    }
}
