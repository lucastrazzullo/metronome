//
//  ObservableMetronomeController.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 7/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

class ObservableMetronomeController<SnapshotType: MetronomeSnapshot>: ObservableMetronome<SnapshotType>, MetronomeController {}
