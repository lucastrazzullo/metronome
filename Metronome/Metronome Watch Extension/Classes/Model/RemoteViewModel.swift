//
//  RemoteSessionViewModel.swift
//  Metronome Watch Extension
//
//  Created by luca strazzullo on 14/6/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import Foundation
import Combine

class RemoteSessionViewModel: ObservableObject {

    @Published var isActiveSession: Bool = false

    let controller: RemoteSessionController

    private var cancellables: [AnyCancellable] = []


    // MARK: Object life cycle

    init(controller: RemoteSessionController) {
        self.controller = controller
        self.controller.sessionPublisher
            .sink { [weak self] _ in self?.isActiveSession = true }
            .store(in: &cancellables)
    }
}
