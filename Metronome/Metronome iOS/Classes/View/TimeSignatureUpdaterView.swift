//
//  TimeSignatureUpdaterView.swift
//  Metronome
//
//  Created by luca strazzullo on 2/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI

struct TimeSignatureUpdaterView: View {

    var timeSignature: TimeSignature
    var color: Color = .orange

    var body: some View {
        ZStack {
            color.edgesIgnoringSafeArea(.all)
            Text("\(timeSignature.bits)/\(timeSignature.noteLength.rawValue)").font(Font.system(.largeTitle))
        }
    }
}
