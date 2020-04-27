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


struct AnyUpdaterViewModel: Hashable, UpdaterViewModel {
    let backgroundColor: String
    let titleLabel: String
    let prefixLabel: String
    let heroLabel: String
    let suffixLabel: String
}


extension UpdaterViewModel {

    func eraseToAnyUpdaterViewModel() -> AnyUpdaterViewModel {
        return AnyUpdaterViewModel(backgroundColor: backgroundColor, titleLabel: titleLabel, prefixLabel: prefixLabel, heroLabel: heroLabel, suffixLabel: suffixLabel)
    }
}


struct UpdaterView: View {

    var model: UpdaterViewModel

    var body: some View {
        ZStack {
            Color(model.backgroundColor).edgesIgnoringSafeArea(.all)
            ZStack(alignment: .center) {
                HStack(alignment: .center) {
                    Text(model.titleLabel).brandFont(.headline)
                    Spacer()
                }
                HStack(alignment: .center, spacing: 4) {
                    Text(model.prefixLabel).brandFont(.body)
                    Text(model.heroLabel).brandFont(.largeTitle)
                    Text(model.suffixLabel).brandFont(.body)
                }
            }
        }
    }
}


struct UpdaterView_Previews: PreviewProvider {

    static var previews: some View {
        let models: [AnyUpdaterViewModel] = [
            SlideTempoUpdaterViewModel(bpm: 90).eraseToAnyUpdaterViewModel(),
            TapTempoUpdaterViewModel(bpm: 40).eraseToAnyUpdaterViewModel(),
            BarLengthUpdaterViewModel(timeSignature: .default).eraseToAnyUpdaterViewModel(),
            NoteLengthUpdaterViewModel(timeSignature: .default).eraseToAnyUpdaterViewModel()
        ]
        return VStack {
            ForEach(models, id: \.self) { viewModel in
                UpdaterView(model: viewModel)
            }
        }
    }
}
