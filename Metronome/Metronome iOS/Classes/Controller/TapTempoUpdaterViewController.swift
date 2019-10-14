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

    var tempo: Tempo {
        return configuration.tempo
    }

    private var tapTimestamps: [TimeInterval] = []
    private var configuration: MetronomeConfiguration {
        didSet {
            rootView.model.tempo = configuration.tempo
        }
    }


    // MARK: Object life cycle

    init(configuration: MetronomeConfiguration) {
        self.configuration = configuration
        super.init(rootView: TempoUpdaterView(model: TempoUpdaterViewModel(tempo: configuration.tempo), foregroundColor: Color.green))
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
        if let tapFrequency = getTapFrequency() {
            configuration.updateTempoWithFrequency(tapFrequency)
        }
        delegate?.tapTempoUpdaterViewController(self, hasSetNew: tempo)
    }


    private func getTapFrequency() -> TimeInterval? {
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
}
