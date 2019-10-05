//
//  MainViewController.swift
//  Metronome
//
//  Created by luca strazzullo on 30/9/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    private var metronomeViewController: MetronomeViewController?

    private var tempoUpdaterGestureRecogniser: UIPanGestureRecognizer?
    private var tempoUpdaterViewController: TempoUpdaterViewController?

    private var barLengthUpdaterGestureRecogniser: UIPanGestureRecognizer?
    private var noteLengthUpdaterGestureRecogniser: UIPinchGestureRecognizer?
    private var timeSignatureUpdaterViewController: TimeSignatureUpdaterViewController?


    // MARK: View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        let configuration = MetronomeConfiguration(timeSignature: TimeSignature.default, tempo: Tempo.default)
        let metronomeViewController = MetronomeViewController(with: configuration)
        self.metronomeViewController = metronomeViewController
        addChildViewController(metronomeViewController, in: view)
    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let tapGestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(toggle))
        view.addGestureRecognizer(tapGestureRecogniser)

        tempoUpdaterGestureRecogniser = UIPanGestureRecognizer(target: self, action: #selector(updateBpm(with:)))
        tempoUpdaterGestureRecogniser?.delegate = self
        tempoUpdaterGestureRecogniser?.minimumNumberOfTouches = 2
        view.addGestureRecognizer(tempoUpdaterGestureRecogniser!)

        barLengthUpdaterGestureRecogniser = UIPanGestureRecognizer(target: self, action: #selector(updateBarLength(with:)))
        barLengthUpdaterGestureRecogniser?.delegate = self
        barLengthUpdaterGestureRecogniser?.minimumNumberOfTouches = 2
        view.addGestureRecognizer(barLengthUpdaterGestureRecogniser!)

        noteLengthUpdaterGestureRecogniser = UIPinchGestureRecognizer(target: self, action: #selector(updateNoteLength(with:)))
        noteLengthUpdaterGestureRecogniser?.delegate = self
        view.addGestureRecognizer(noteLengthUpdaterGestureRecogniser!)
    }


    // MARK: UI Callbacks

    @objc private func toggle() {
        metronomeViewController?.toggle()
    }


    @objc private func updateBpm(with gestureRecogniser: UIPanGestureRecognizer) {
        switch gestureRecogniser.state {
        case .began:
            if let configuration = metronomeViewController?.getCurrentConfiguration() {
                tempoUpdaterViewController = TempoUpdaterViewController(tempo: configuration.tempo)
                addChildViewController(tempoUpdaterViewController!, in: view)
            }
        case .changed:
            tempoUpdaterViewController?.updateBpm(with: Int(-gestureRecogniser.translation(in: view).y / 8))
        case .ended:
            if let configuration = metronomeViewController?.getCurrentConfiguration(), let newTempo = tempoUpdaterViewController?.tempo {
                var newConfiguration = configuration
                newConfiguration.tempo = newTempo
                metronomeViewController?.setNewConfiguration(newConfiguration)
            }
            removeChildViewController(tempoUpdaterViewController)
        default:
            break
        }
    }


    @objc private func updateBarLength(with gestureRecogniser: UIPanGestureRecognizer) {
        switch gestureRecogniser.state {
        case .began:
            if let configuration = metronomeViewController?.getCurrentConfiguration() {
                timeSignatureUpdaterViewController = TimeSignatureUpdaterViewController(timeSignature: configuration.timeSignature)
                addChildViewController(timeSignatureUpdaterViewController!, in: view)
            }
        case .changed:
            timeSignatureUpdaterViewController?.updateBarLength(with: Int(gestureRecogniser.translation(in: view).x))
        case .ended:
            if let configuration = metronomeViewController?.getCurrentConfiguration(), let newTimeSignature = timeSignatureUpdaterViewController?.timeSignature {
                var newConfiguration = configuration
                newConfiguration.timeSignature = newTimeSignature
                metronomeViewController?.setNewConfiguration(newConfiguration)
            }
            removeChildViewController(timeSignatureUpdaterViewController)
        default:
            break
        }
    }


    @objc private func updateNoteLength(with gestureRecogniser: UIPinchGestureRecognizer) {
        switch gestureRecogniser.state {
        case .began:
            if let configuration = metronomeViewController?.getCurrentConfiguration() {
                timeSignatureUpdaterViewController = TimeSignatureUpdaterViewController(timeSignature: configuration.timeSignature)
                addChildViewController(timeSignatureUpdaterViewController!, in: view)
            }
        case .changed:
            timeSignatureUpdaterViewController?.updateNoteLength(with: (Int(round(gestureRecogniser.scale * 10)) - 10) / 2)
        case .ended:
            if let configuration = metronomeViewController?.getCurrentConfiguration(), let newTimeSignature = timeSignatureUpdaterViewController?.timeSignature {
                var newConfiguration = configuration
                newConfiguration.timeSignature = newTimeSignature
                metronomeViewController?.setNewConfiguration(newConfiguration)
            }
            removeChildViewController(timeSignatureUpdaterViewController)
        default:
            break
        }
    }


    // MARK: Private helper methods

    private func addChildViewController(_ viewController: UIViewController, in view: UIView) {
        viewController.willMove(toParent: self)
        addChild(viewController)
        view.addSubview(viewController.view)
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            viewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            view.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor)
        ])
        viewController.didMove(toParent: self)
    }


    private func removeChildViewController(_ viewController: UIViewController?) {
        viewController?.willMove(toParent: nil)
        viewController?.view.removeFromSuperview()
        viewController?.removeFromParent()
        viewController?.didMove(toParent: nil)
    }
}


extension MainViewController: UIGestureRecognizerDelegate {

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let tempoUpdaterGestureRecogniser = tempoUpdaterGestureRecogniser, tempoUpdaterGestureRecogniser == gestureRecognizer {
            return abs(tempoUpdaterGestureRecogniser.velocity(in: view).y) > abs(tempoUpdaterGestureRecogniser.velocity(in: view).x)
        }
        if let barLengthUpdaterGestureRecogniser = barLengthUpdaterGestureRecogniser, barLengthUpdaterGestureRecogniser == gestureRecognizer {
            return abs(barLengthUpdaterGestureRecogniser.velocity(in: view).y) < abs(barLengthUpdaterGestureRecogniser.velocity(in: view).x)
        }
        if let noteLengthUpdaterGestureRecogniser = noteLengthUpdaterGestureRecogniser, noteLengthUpdaterGestureRecogniser == gestureRecognizer {
            return true
        }
        return false
    }
}
