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

    @State var tapIndicatorHighlighted: Bool = false


    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 12) {
                HStack(alignment: .center, spacing: 12) {
                    Text(Copy.Picker.TapTempo.title.localised)
                        .brandFont(.title)

                    Circle()
                        .foregroundColor(tapIndicatorHighlighted ? Palette.purple.color : Palette.white.color)
                        .frame(width: 8, height: 8, alignment: .center)
                }

                Spacer()

                VStack {
                    Text(getValueString().uppercased())
                        .brandFont(.largeTitle)

                    Text(Copy.Tempo.unit.localised)
                        .brandFont(.callout)
                        .opacity(0.36)
                }

                Spacer()

                Button(action: complete) {
                    HStack {
                        Spacer()
                        Text(Copy.Controls.done.localised)
                            .font(Font.callout)
                        Spacer()
                    }
                }
                .padding(16)
                .background(Palette.white.color.opacity(0.2))
                .cornerRadius(8)
            }
        }
        .padding(.top, 24)
        .padding([.bottom, .leading, .trailing], 4)
        .background(LinearGradient(.greenBlue).edgesIgnoringSafeArea(.all))
        .foregroundColor(Palette.black.color)
        .gesture(TapGesture()
            .onEnded { gesture in
                self.viewModel.update(with: Date().timeIntervalSinceReferenceDate)
                self.tapIndicatorHighlighted.toggle()
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


    private func complete() {
        viewModel.commit()
        presentationMode.wrappedValue.dismiss()
    }
}


// MARK: Previews

struct TapTempoPickerView_Preview: PreviewProvider {

    static var previews: some View {
        let metronome = Metronome(with: .default, soundOn: false)
        let viewModel = TapTempoPickerViewModel(metronome: metronome)
        return TapTempoPickerView(viewModel: viewModel)
            .previewLayout(.fixed(width: 568, height: 320))
    }
}
