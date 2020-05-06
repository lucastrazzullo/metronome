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


    // MARK: Body

    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Picker(selection: self.$viewModel.selectedTempoItem,
                   label: Text(Copy.Tempo.unit.localised).padding(2)) {
                ForEach(self.viewModel.tempoItems, id: \.self) { item in
                    Text(item.label).font(.largeTitle)
                }
            }
            Button(action: {
                self.viewModel.commit()
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Text(Copy.Controls.confirm.localised)
            })
        }
    }
}
