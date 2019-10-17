//
//  TapTempoUpdaterViewController.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 12/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI

protocol TapTempoUpdaterViewControllerDelegate: AnyObject {
    func tapTempoUpdaterViewController(_ viewController: TapTempoUpdaterViewController, bpmFor timestamps: [TimeInterval]) -> Int?
}


class TapTempoUpdaterViewController: UIHostingController<UpdaterView> {

    weak var delegate: TapTempoUpdaterViewControllerDelegate?

    private var tapTimestamps: [TimeInterval] = [] {
        didSet {
            rootView.model = TapTempoUpdaterViewModel(bpm: delegate?.tapTempoUpdaterViewController(self, bpmFor: tapTimestamps))
        }
    }


    // MARK: Object life cycle

    init() {
        super.init(rootView: UpdaterView(model: TapTempoUpdaterViewModel(bpm: nil)))
    }


    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: View life cycle

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let gestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(setTempo(with:)))
        gestureRecogniser.numberOfTapsRequired = 1
        view.addGestureRecognizer(gestureRecogniser)
    }


    // MARK: UI Callbacks

    @objc private func setTempo(with gestureRecogniser: UITapGestureRecognizer) {
        switch gestureRecogniser.state {
        case .recognized:
            updateConfigutation(withNewTap: Date().timeIntervalSinceReferenceDate)
        default:
            break
        }
    }


    // MARK: Private helper methods

    private func updateConfigutation(withNewTap timestamp: TimeInterval) {
        tapTimestamps.append(timestamp)
        if tapTimestamps.count > 5 {
            tapTimestamps.remove(at: 0)
        }
    }
}
