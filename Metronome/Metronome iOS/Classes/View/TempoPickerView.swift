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

    @ObservedObject var viewModel: TempoPickerViewModel


    // MARK: Body

    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 12) {
                Text(Copy.Tempo.title.localised)
                    .brandFont(.title)

                Spacer()

                VStack {
                    Text(Copy.Tempo.unit.localised)
                        .brandFont(.callout)
                        .opacity(0.36)

                    HStack(alignment: .center, spacing: 28) {
                        PickerButton(icon: .minus, action: viewModel.decreaseTempo)
                            .brandFont(.title)
                            .frame(width: 46, height: 46)

                        Text(String(Int(viewModel.selectedTempoBpm)))
                            .brandFont(.largeTitle)
                            .frame(minWidth: 100)

                        PickerButton(icon: .plus, action: viewModel.increaseTempo)
                            .brandFont(.title)
                            .frame(width: 46, height: 46)
                    }
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
        .padding(.top, 12)
        .padding([.bottom, .leading, .trailing], 4)
        .background(LinearGradient.oblique(.yellowGreen).edgesIgnoringSafeArea(.all))
        .foregroundColor(Palette.black.color)
    }


    // MARK: Private helper methods

    private func complete() {
        viewModel.commit()
        presentationMode.wrappedValue.dismiss()
    }
}


// MARK: Previews

struct TempoPickerView_Preview: PreviewProvider {

    static var previews: some View {
        let metronome = Metronome(with: .default, soundOn: false)
        let controller = MetronomeSessionController(metronome: metronome)
        let viewModel = TempoPickerViewModel(controller: controller)
        return TempoPickerView(viewModel: viewModel)
            .previewLayout(.fixed(width: 568, height: 320))
    }
}
