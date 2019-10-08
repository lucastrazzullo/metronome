//
//  UpdateTimeSignatureView.swift
//  Metronome Watch Extension
//
//  Created by luca strazzullo on 8/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI
import Combine

struct UpdateTimeSignatureView: View {

    @ObservedObject var observed: ObservableMetronome<MetronomeViewModel>


    // MARK: Body

    var body: some View {
        Text("Current time signature: \(observed.snapshot.timeSignatureLabel)")
    }
}
