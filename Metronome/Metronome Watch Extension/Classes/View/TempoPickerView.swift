//
//  TempoPickerView.swift
//  Metronome Watch Extension
//
//  Created by luca strazzullo on 8/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI
import Combine

struct TempoPickerView: View {

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State var viewModel: TempoPickerViewModel
    @State var completion: ((Tempo) -> ())


    // MARK: Body

    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Picker(selection: self.$viewModel.selectedTempoItem,
                   label: Text(Copy.localised(with: Copy.Tempo.suffix)).padding(2)) {
                ForEach(self.viewModel.tempoItems, id: \.self) { item in
                    Text(item.label).font(.largeTitle)
                }
            }
            Button(action: {
                self.completion(Tempo(bpm: self.viewModel.selectedTempoItem.bpm))
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Text(Copy.localised(with: Copy.Action.confirm))
            })
        }
    }
}
