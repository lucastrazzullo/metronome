//
//  ControlsView.swift
//  Metronome Macos
//
//  Created by luca strazzullo on 28/4/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import SwiftUI

struct ControlsView: View {

    let model: ControlsViewModel
    let toggle: () -> ()

    var body: some View {
        HStack {
            Button(action: { self.toggle() }) {
                Text(model.toggleLabel)
            }
        }
    }
}
