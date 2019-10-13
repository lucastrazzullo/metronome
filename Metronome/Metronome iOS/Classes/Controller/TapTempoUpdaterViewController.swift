//
//  TapTempoUpdaterViewController.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 12/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI

protocol TapTempoUpdaterViewControllerDelegate: AnyObject {
    func tapTempoUpdaterViewController(_ viewController: TapTempoUpdaterViewController, hasSetNew tempo: Tempo)
}


class TapTempoUpdaterViewController: UIHostingController<TempoUpdaterView> {

    weak var delegate: TapTempoUpdaterViewControllerDelegate?

    private var tapTimestamps: [TimeInterval] = [] {
        didSet {
            if tapTimestamps.count > 5 {
                tapTimestamps.remove(at: 0)
            }
            if let tapFrequency = tapFrequency {
                configuration.updateTempoWithFrequency(tapFrequency)
            }
        }
    }

    private var tapFrequency: TimeInterval? {
        guard tapTimestamps.count >= 2 else { return nil }

        let frequencies: [Double] = tapTimestamps.enumerated().compactMap { index, timestamp in
            if index + 1 == tapTimestamps.count {
                return nil
            } else {
                return tapTimestamps[index + 1] - timestamp
            }
        }
        return frequencies.reduce(0, +) / Double(frequencies.count)
    }

    private var configuration: MetronomeConfiguration {
        didSet {
            rootView.bpm = configuration.tempo.bpm
        }
    }

    private var timer: Timer?


    // MARK: Object life cycle

    init(configuration: MetronomeConfiguration) {
        self.configuration = configuration
        super.init(rootView: TempoUpdaterView(bpm: configuration.tempo.bpm))
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

    @objc func setTempo(with gestureRecogniser: UITapGestureRecognizer) {
        switch gestureRecogniser.state {
        case .recognized:
            tapTimestamps.append(Date().timeIntervalSinceReferenceDate)
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: {
                [weak self] timer in
                if let unwrappedSelf = self {
                    self?.delegate?.tapTempoUpdaterViewController(unwrappedSelf, hasSetNew: unwrappedSelf.configuration.tempo)
                }
            })
        default:
            break
        }
    }
}
