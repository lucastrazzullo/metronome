//
//  MainViewController.swift
//  Metronome
//
//  Created by luca strazzullo on 30/9/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, ContainerViewController {

    private var metronomeViewController: MetronomeViewController?
    private var metronomeGestureViewController: MetronomeGestureViewController?


    // MARK: View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        let configuration = MetronomeConfiguration(timeSignature: TimeSignature.default, tempo: Tempo.default)
        let observableMetronome = ObservableMetronome<MetronomeViewModel>(with: configuration)

        let metronomeViewController = MetronomeViewController(with: observableMetronome)
        self.metronomeViewController = metronomeViewController
        addChildViewController(metronomeViewController, in: view)

        let metronomeGestureViewController = MetronomeGestureViewController(with: observableMetronome)
        self.metronomeGestureViewController = metronomeGestureViewController
        addChildViewController(metronomeGestureViewController, in: view)
    }
}
