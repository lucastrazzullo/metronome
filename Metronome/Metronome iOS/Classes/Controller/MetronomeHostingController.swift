//
//  MetronomeHostingController.swift
//  Metronome
//
//  Created by luca strazzullo on 30/9/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI
import Combine

class MetronomeHostingController: UIHostingController<AnyView>, ContainerViewController {

    init(with controller: MetronomeController) {
        let viewModel = MetronomeViewModel(metronomeController: controller)
        let view = AnyView(MetronomeView(viewModel: viewModel))
        super.init(rootView: view)
    }


    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
