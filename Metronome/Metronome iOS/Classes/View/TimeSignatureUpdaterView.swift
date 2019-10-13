//
//  TimeSignatureUpdaterView.swift
//  Metronome
//
//  Created by luca strazzullo on 2/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI

struct TimeSignatureUpdaterView: View {

    var model: TimeSignatureUpdaterViewModel
    var backgroundColor: Color = .orange

    var body: some View {
        ZStack {
            backgroundColor.edgesIgnoringSafeArea(.all)
            Text(model.timeSignatureLabel).font(Font.system(.largeTitle))
        }
    }
}
