//
//  TempoPickerViewModel.swift
//  Metronome Watch Extension
//
//  Created by luca strazzullo on 4/5/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import Foundation
import Combine

class TempoPickerViewModel: ObservableObject {

    struct TempoItem: Hashable {

        let bpm: Int
        let label: String

        var tempo: Tempo {
            return Tempo(bpm: bpm)
        }

        init(bpm: Int) {
            self.bpm = bpm
            self.label = String(bpm)
        }
    }


    // MARK: Instance properties

    @Published var selectedTempoItem: TempoItem

    private(set) var tempoItems: [TempoItem]


    // MARK: Object life cycle

    init(tempo: Tempo) {
        tempoItems = (Tempo.minimumBpm ... Tempo.maximumBpm).map(TempoItem.init(bpm:))
        selectedTempoItem = TempoItem.init(bpm: tempo.bpm)
    }
}
