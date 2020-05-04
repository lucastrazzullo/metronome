//
//  GesturePickerView.swift
//  Metronome
//
//  Created by luca strazzullo on 2/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI

protocol GesturePickerViewModel {
    var backgroundColor: String { get }
    var titleLabel: String { get }
    var prefixLabel: String { get }
    var heroLabel: String { get }
    var suffixLabel: String { get }
}


struct AnyGesturePickerViewModel: Hashable, GesturePickerViewModel {
    let backgroundColor: String
    let titleLabel: String
    let prefixLabel: String
    let heroLabel: String
    let suffixLabel: String
}


extension GesturePickerViewModel {

    func eraseToAnyGesturePicker() -> AnyGesturePickerViewModel {
        return AnyGesturePickerViewModel(backgroundColor: backgroundColor, titleLabel: titleLabel, prefixLabel: prefixLabel, heroLabel: heroLabel, suffixLabel: suffixLabel)
    }
}


struct GesturePickerView: View {

    var model: GesturePickerViewModel

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


struct GesturePickerView_Previews: PreviewProvider {

    static var previews: some View {
        let models: [AnyGesturePickerViewModel] = [
            SlideTempoPickerViewModel(bpm: 90).eraseToAnyGesturePicker(),
            TapTempoPickerViewModel(bpm: 40).eraseToAnyGesturePicker(),
            BarLengthPickerViewModel(timeSignature: .default).eraseToAnyGesturePicker(),
            NoteLengthPickerViewModel(timeSignature: .default).eraseToAnyGesturePicker()
        ]
        return VStack {
            ForEach(models, id: \.self) { viewModel in
                GesturePickerView(model: viewModel)
            }
        }
    }
}
