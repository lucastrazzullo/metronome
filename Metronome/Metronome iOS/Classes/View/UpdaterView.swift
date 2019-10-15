//
//  UpdaterView.swift
//  Metronome
//
//  Created by luca strazzullo on 2/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI

protocol UpdaterViewModel {
    var backgroundColor: String { get }
    var titleLabel: String { get }
    var prefixLabel: String { get }
    var heroLabel: String { get }
    var suffixLabel: String { get }
}


struct UpdaterView: View {

    var model: UpdaterViewModel

    var body: some View {
        ZStack {
            Color(model.backgroundColor).edgesIgnoringSafeArea(.all)
            ZStack(alignment: .center) {
                HStack(alignment: .center) {
                    Text(model.titleLabel).font(Font.custom("AmericanTypewriter", size: 34))
                    Spacer()
                }
                HStack(alignment: .center, spacing: 4) {
                    Text(model.prefixLabel).font(Font.custom("AmericanTypewriter", size: 22))
                    Text(model.heroLabel).font(Font.custom("AmericanTypewriter", size: 88))
                    Text(model.suffixLabel).font(Font.custom("AmericanTypewriter", size: 22))
                }
            }
        }
    }
}
