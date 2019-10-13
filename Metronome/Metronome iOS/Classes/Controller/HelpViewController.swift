//
//  HelpViewController.swift
//  Metronome
//
//  Created by luca strazzullo on 6/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI

class HelpViewController: UIHostingController<HelpView> {

    private var timer: Timer?


    // MARK: View life cycle

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true, block: {
            [weak self] timer in
            self?.rootView.model.nextTip()
        })
    }


    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
    }
}
