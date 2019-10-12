//
//  GestureController.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 12/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import UIKit

protocol GestureController: AnyObject {
    var delegate: UIContainerViewController? { get set }
    var gestureRecogniser: UIGestureRecognizer { get }
}
