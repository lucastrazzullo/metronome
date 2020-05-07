//
//  TempoPickerView.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 6/5/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import SwiftUI
import Combine

struct TempoPickerView: View {

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State var viewModel: TempoPickerViewModel


    // MARK: Body

    var body: some View {
        ZStack {
            Palette.yellow.color.edgesIgnoringSafeArea(.all)

            HStack(alignment: .center, spacing: 80) {
                HStack(alignment: .center) {
                    Text(Copy.Tempo.title.localised).brandFont(.headline)
                }

                HStack(alignment: .center, spacing: 24) {
                    Picker(selection: $viewModel.selectedTempo, label: Text(Copy.Tempo.unit.localised)) {
                        ForEach(self.viewModel.tempoItems, id: \.self) { bpm in
                            Text(String(bpm)).font(.largeTitle)
                        }
                    }
                    .frame(width: 120, height: nil, alignment: .center)
                    .clipped()

                    Text(Copy.Tempo.unit.localised).brandFont(.title1)
                    .fixedSize(horizontal: true, vertical: true)
                }

                HStack(alignment: .center) {
                    Button(action: {
                        self.viewModel.commit()
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: { Text(Copy.Controls.confirm.localised.uppercased()).font(Font.callout) })
                }
                .padding(8)
                .background(Palette.black.color.opacity(0.2))
                .cornerRadius(8)
            }

        }.foregroundColor(Palette.black.color)
    }
}
