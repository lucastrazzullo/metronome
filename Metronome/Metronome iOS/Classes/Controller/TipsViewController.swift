//
//  TipsViewController.swift
//  Metronome
//
//  Created by luca strazzullo on 6/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI

class TipsViewController: UIHostingController<TipsView> {

    init(completion: @escaping () -> ()) {
        let tips = TipsViewModelRepository.all
        let viewModel = HelpViewModel(tips: tips)
        let view = TipsView(model: viewModel, dismiss: completion)
        super.init(rootView: view)
    }


    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
