//
//  WelcomeViewController.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 16/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI

protocol WelcomeViewControllerDelegate: AnyObject {
    func welcomeViewControllerHasCompleted(_ viewController: WelcomeViewController)
}


class WelcomeViewController: UIContainerViewController {

    weak var delegate: WelcomeViewControllerDelegate?

    private var helpViewController: UIViewController?
    private let cache: WelcomeCache


    // MARK: Object life cycle

    init() {
        cache = WelcomeCache(entry: UserDefaultBackedEntryCache())
        super.init(nibName: nil, bundle: nil)
    }


    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: View life cycle

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presentIfNeeded()
    }


    // MARK: Private helper methods

    private func presentIfNeeded() {
        if let hasBeenPresented = cache.hasBeenPresented, hasBeenPresented {
            dismiss()
        } else {
            cache.hasBeenPresented = true
            present()
        }
    }


    private func present() {
        let viewController = TipsViewController(completion: dismiss)
        self.helpViewController = viewController
        present(viewController, animated: true, completion: nil)
    }


    private func dismiss() {
        if let helpViewController = helpViewController {
            helpViewController.dismiss(animated: true, completion: {
                [weak self] in
                if let viewController = self {
                    self?.delegate?.welcomeViewControllerHasCompleted(viewController)
                }
            })
        } else {
            delegate?.welcomeViewControllerHasCompleted(self)
        }
    }
}
