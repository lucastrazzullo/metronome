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
    private var metronomePlayerViewController: GestureMetronomePlayerViewController?


    // MARK: View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        let configuration = MetronomeConfiguration(timeSignature: TimeSignature.default, tempo: Tempo.default)
        let metronome = Metronome(with: configuration)
        let observableMetronome = ObservableMetronomeController<MetronomeViewModel>(metronome: metronome)

        let metronomeViewController = MetronomeViewController(with: observableMetronome)
        self.metronomeViewController = metronomeViewController
        addChildViewController(metronomeViewController, in: view)

        let metronomePlayerViewController = GestureMetronomePlayerViewController(with: observableMetronome)
        self.metronomePlayerViewController = metronomePlayerViewController
        addChildViewController(metronomePlayerViewController, in: view)
    }
}
