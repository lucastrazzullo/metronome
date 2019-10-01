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
    private var tempoUpdaterViewController: TempoUpdaterViewController?


    // MARK: View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        let configuration = MetronomeConfiguration(timeSignature: TimeSignature(bits: 6, noteLength: 8), tempo: Tempo.default)
        let metronomeViewController = MetronomeViewController(with: configuration)
        self.metronomeViewController = metronomeViewController
        addChildViewController(metronomeViewController, in: view)
    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let tapGestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(toggle))
        view.addGestureRecognizer(tapGestureRecogniser)

        let panGestureRecogniser = UIPanGestureRecognizer(target: self, action: #selector(updateTempo(with:)))
        view.addGestureRecognizer(panGestureRecogniser)
    }


    // MARK: UI Callbacks

    @objc private func toggle() {
        metronomeViewController?.toggle()
    }


    @objc private func updateTempo(with gestureRecogniser: UIPanGestureRecognizer) {
        switch gestureRecogniser.state {
        case .began:
            if let configuration = metronomeViewController?.getCurrentConfiguration() {
                tempoUpdaterViewController = TempoUpdaterViewController(tempo: configuration.tempo)
                addChildViewController(tempoUpdaterViewController!, in: view)
            }
        case .changed:
            tempoUpdaterViewController?.update(with: -gestureRecogniser.translation(in: view).y)
        case .ended:
            if let configuration = metronomeViewController?.getCurrentConfiguration(), let newTempo = tempoUpdaterViewController?.finalTempo {
                var newConfiguration = configuration
                newConfiguration.tempo = newTempo
                metronomeViewController?.setNewConfiguration(newConfiguration)
            }
            removeChildViewController(tempoUpdaterViewController)
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
