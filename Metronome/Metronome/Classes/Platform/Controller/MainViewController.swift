//
//  MainViewController.swift
//  Metronome
//
//  Created by luca strazzullo on 30/9/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let configuration = MetronomeConfiguration(timeSignature: TimeSignature(bits: 6, noteLength: 8), tempo: Tempo.default)
        let metronomeViewController = MetronomeViewController(with: configuration)
        addChildViewController(metronomeViewController, in: view)
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
}
