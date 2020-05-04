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

    struct Item: Hashable {

        let bpm: Int
        let label: String

        init(bpm: Int) {
            self.bpm = bpm
            self.label = String(bpm)
        }
    }


    // MARK: Instance properties

    @Published var selectedTempoItem: Item

    private(set) var tempoItems: [Item]


    // MARK: Object life cycle

    init(tempo: Tempo) {
        tempoItems = Tempo.range.map(Item.init(bpm:))
        selectedTempoItem = Item(bpm: tempo.bpm)
    }
}
