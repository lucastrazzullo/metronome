//
//  ContainerViewController.swift
//  Metronome
//
//  Created by luca strazzullo on 5/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import UIKit

protocol ContainerViewController: AnyObject {
    func addChildViewController(_ viewController: UIViewController, in view: UIView?)
    func removeChildViewController(_ viewController: UIViewController?)
}


extension ContainerViewController where Self: UIViewController {

    func addChildViewController(_ viewController: UIViewController, in view: UIView?) {
        guard let view = view else { return }

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


    func removeChildViewController(_ viewController: UIViewController?) {
        viewController?.willMove(toParent: nil)
        viewController?.view.removeFromSuperview()
        viewController?.removeFromParent()
        viewController?.didMove(toParent: nil)
    }
}

typealias UIContainerViewController = UIViewController & ContainerViewController
