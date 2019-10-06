//
//  HelpView.swift
//  Metronome
//
//  Created by luca strazzullo on 6/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI

struct HelpView: View {

    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            Text("Tap to play. Slide two fingers up/down or left/right").foregroundColor(.black).font(Font.system(.largeTitle))
        }
    }
}
