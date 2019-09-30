//
//  ViewController.swift
//  Metronome
//
//  Created by luca strazzullo on 30/9/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let metronome = Metronome()


    // MARK: UI

    @IBOutlet private var toggle: UIButton!
    @IBOutlet private var label: UILabel!


    // MARK: View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        metronome.delegate = self
    }


    // MARK: UI Callbacks

    @IBAction func toggleMetronome() {
        if metronome.isPlaying {
            metronome.reset()
            toggle.setTitle("Play", for: .normal)
        } else {
            metronome.start()
            toggle.setTitle("Reset", for: .normal)
        }
    }
}


extension ViewController: MetronomeDelegate {

    func metronome(_ metronome: Metronome, didTick bit: Int) {
        label.text = String(bit)
    }
}
