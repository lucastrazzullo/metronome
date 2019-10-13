//
//  TempoUpdaterView.swift
//  Metronome
//
//  Created by luca strazzullo on 1/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI

struct TempoUpdaterView: View {

    var model: TempoUpdaterViewModel

    var body: some View {
        ZStack {
            Color.yellow.edgesIgnoringSafeArea(.all)
            Text(model.tempoLabel).font(Font.system(.largeTitle))
        }
    }
}
