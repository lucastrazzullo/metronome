//
//  MetronomeViewController.swift
//  Metronome
//
//  Created by luca strazzullo on 30/9/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import UIKit
import SwiftUI

class MetronomeViewController: UIHostingController<MetronomeView> {

    private let metronomeController: ObservableMetronomeController<MetronomeViewModel>
    private let impactGenerator: UIImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .soft)


    // MARK: Object life cycle

    init(with observableMetronomeController: ObservableMetronomeController<MetronomeViewModel>) {
        metronomeController = observableMetronomeController
        super.init(rootView: MetronomeView(observed: observableMetronomeController))
    }


    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: View life cycle

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        metronomeController.reset()
    }
}


//
//extension MetronomeViewController: MetronomeTickerDelegate {
//
//    func metronomeTickerDidStart(_ ticker: MetronomeTicker) {
//        UIApplication.shared.isIdleTimerDisabled = true
//    }
//
//
//    func metronomeTickerDidReset(_ ticker: MetronomeTicker) {
//        UIApplication.shared.isIdleTimerDisabled = false
//    }
//
//
//    func metronomeTicker(_ ticker: MetronomeTicker, didTick iteration: Int) {
//        impactGenerator.impactOccurred()
//    }
//}
