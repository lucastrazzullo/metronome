//
//  TipView.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 15/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI

struct TipView: View {

    static var minimumWidth: CGFloat = 145

    var viewModel: TipViewModel

    var body: some View {
        VStack(alignment: .center, spacing: 40) {
            Image(viewModel.illustration)
                .frame(width: 90, height: 90, alignment: .center)
            VStack(alignment: .leading, spacing: 8) {
                Text(viewModel.title)
                    .brandFont(.title2)
                    .multilineTextAlignment(.leading)
                Text(viewModel.description)
                    .brandFont(.body)
                    .multilineTextAlignment(.leading)
            }
        }
    }
}
