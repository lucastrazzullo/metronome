//
//  TapTempoPickerView.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 7/5/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import SwiftUI

struct TapTempoPickerView: View {

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @ObservedObject var viewModel: TapTempoPickerViewModel


    var body: some View {
        ZStack {
            Palette.green.color.edgesIgnoringSafeArea(.all)

            HStack(alignment: .center, spacing: 80) {
                HStack(alignment: .center) {
                    Text(Copy.Picker.TapTempo.title.localised).brandFont(.headline)
                }

                HStack {
                    Text(getValueString()).brandFont(.largeTitle)
                    Text(Copy.Tempo.unit.localised).brandFont(.title1)
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
        }
        .foregroundColor(Palette.black.color)
        .gesture(TapGesture().onEnded { gesture in
            self.viewModel.selectTemporarely(newTapWith: Date().timeIntervalSinceReferenceDate)
        })
    }


    // MARK: Private helper methods

    private func getValueString() -> String {
        if let bpm = viewModel.selectedTempoBpm {
            return String(bpm)
        } else {
            return Copy.Picker.TapTempo.valuePlaceholder.localised
        }
    }
}
