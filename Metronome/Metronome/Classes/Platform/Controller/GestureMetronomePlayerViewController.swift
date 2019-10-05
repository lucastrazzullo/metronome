//
//  GestureMetronomePlayerViewController.swift
//  Metronome
//
//  Created by luca strazzullo on 5/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import UIKit

class GestureMetronomePlayerViewController: UIViewController, ContainerViewController {

    weak var metronomeController: MetronomeController?

    private var tempoUpdaterViewController: TempoUpdaterViewController?
    private var timeSignatureUpdaterViewController: TimeSignatureUpdaterViewController?

    private var togglerGestureRecogniser: UITapGestureRecognizer?
    private var tempoUpdaterGestureRecogniser: UIPanGestureRecognizer?
    private var barLengthUpdaterGestureRecogniser: UIPanGestureRecognizer?
    private var noteLengthUpdaterGestureRecogniser: UIPinchGestureRecognizer?


    // MARK: Object life cycle

    init() {
        super.init(nibName: nil, bundle: nil)
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        togglerGestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(handleGestureRecogniser(with:)))
        togglerGestureRecogniser?.delegate = self
        view.addGestureRecognizer(togglerGestureRecogniser!)

        tempoUpdaterGestureRecogniser = UIPanGestureRecognizer(target: self, action: #selector(handleGestureRecogniser(with:)))
        tempoUpdaterGestureRecogniser?.delegate = self
        tempoUpdaterGestureRecogniser?.minimumNumberOfTouches = 2
        view.addGestureRecognizer(tempoUpdaterGestureRecogniser!)

        barLengthUpdaterGestureRecogniser = UIPanGestureRecognizer(target: self, action: #selector(handleGestureRecogniser(with:)))
        barLengthUpdaterGestureRecogniser?.delegate = self
        barLengthUpdaterGestureRecogniser?.minimumNumberOfTouches = 2
        view.addGestureRecognizer(barLengthUpdaterGestureRecogniser!)

        noteLengthUpdaterGestureRecogniser = UIPinchGestureRecognizer(target: self, action: #selector(handleGestureRecogniser(with:)))
        noteLengthUpdaterGestureRecogniser?.delegate = self
        view.addGestureRecognizer(noteLengthUpdaterGestureRecogniser!)
    }


    // MARK: UI Callbacks

    @objc private func handleGestureRecogniser(with gestureRecogniser: UIGestureRecognizer) {
        switch gestureRecogniser.state {
        case .began:
            handleGestureBegan(for: gestureRecogniser)
        case .changed:
            handleGestureChanged(for: gestureRecogniser)
        case .ended:
            handleGestureEnded(for: gestureRecogniser)
        default:
            break
        }
    }


    private func handleGestureBegan(for gestureRecogniser: UIGestureRecognizer) {
        if let tempoUpdaterGestureRecogniser = tempoUpdaterGestureRecogniser, tempoUpdaterGestureRecogniser == gestureRecogniser {
            if let tempo = metronomeController?.tempo {
                tempoUpdaterViewController = TempoUpdaterViewController(tempo: tempo)
                addChildViewController(tempoUpdaterViewController!, in: view)
            }
        }
        if let barLengthUpdaterGestureRecogniser = barLengthUpdaterGestureRecogniser, barLengthUpdaterGestureRecogniser == gestureRecogniser {
            if let timeSignature = metronomeController?.timeSignature {
                timeSignatureUpdaterViewController = TimeSignatureUpdaterViewController(timeSignature: timeSignature)
                addChildViewController(timeSignatureUpdaterViewController!, in: view)
            }
        }
        if let noteLengthUpdaterGestureRecogniser = noteLengthUpdaterGestureRecogniser, noteLengthUpdaterGestureRecogniser == gestureRecogniser {
            if let timeSignature = metronomeController?.timeSignature {
                timeSignatureUpdaterViewController = TimeSignatureUpdaterViewController(timeSignature: timeSignature)
                addChildViewController(timeSignatureUpdaterViewController!, in: view)
            }
        }
    }


    private func handleGestureChanged(for gestureRecogniser: UIGestureRecognizer) {
        if let tempoUpdaterGestureRecogniser = tempoUpdaterGestureRecogniser, tempoUpdaterGestureRecogniser == gestureRecogniser {
            tempoUpdaterViewController?.updateBpm(with: Int(-tempoUpdaterGestureRecogniser.translation(in: view).y / 8))
        }
        if let barLengthUpdaterGestureRecogniser = barLengthUpdaterGestureRecogniser, barLengthUpdaterGestureRecogniser == gestureRecogniser {
            timeSignatureUpdaterViewController?.updateBarLength(with: Int(barLengthUpdaterGestureRecogniser.translation(in: view).x))
        }
        if let noteLengthUpdaterGestureRecogniser = noteLengthUpdaterGestureRecogniser, noteLengthUpdaterGestureRecogniser == gestureRecogniser {
            timeSignatureUpdaterViewController?.updateNoteLength(with: (Int(round(noteLengthUpdaterGestureRecogniser.scale * 10)) - 10) / 2)
        }
    }


    private func handleGestureEnded(for gestureRecogniser: UIGestureRecognizer) {
        if let togglerGestureRecogniser = togglerGestureRecogniser, togglerGestureRecogniser == gestureRecogniser {
            metronomeController?.toggle()
        }
        if let tempoUpdaterGestureRecogniser = tempoUpdaterGestureRecogniser, tempoUpdaterGestureRecogniser == gestureRecogniser {
            metronomeController?.updateTempo(tempoUpdaterViewController?.tempo)
            removeChildViewController(tempoUpdaterViewController)
        }
        if let barLengthUpdaterGestureRecogniser = barLengthUpdaterGestureRecogniser, barLengthUpdaterGestureRecogniser == gestureRecogniser {
            metronomeController?.updateTimeSignature(timeSignatureUpdaterViewController?.timeSignature)
            removeChildViewController(timeSignatureUpdaterViewController)
        }
        if let noteLengthUpdaterGestureRecogniser = noteLengthUpdaterGestureRecogniser, noteLengthUpdaterGestureRecogniser == gestureRecogniser {
            metronomeController?.updateTimeSignature(timeSignatureUpdaterViewController?.timeSignature)
            removeChildViewController(timeSignatureUpdaterViewController)
        }
    }
}


extension GestureMetronomePlayerViewController: UIGestureRecognizerDelegate {

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let togglerGestureRecogniser = togglerGestureRecogniser, togglerGestureRecogniser == gestureRecognizer {
            return true
        }
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