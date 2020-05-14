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

                HStack(alignment: .center, spacing: 28) {
                    PickerButton(icon: .minus, action: viewModel.decreaseTempo)
                        .brandFont(.title)

                    VStack {
                        Text(String(viewModel.temporarySelectedTempo))
                            .brandFont(.largeTitle)
                        Text(Copy.Tempo.unit.localised)
                            .brandFont(.callout)
                            .opacity(0.36)
                    }

                    PickerButton(icon: .plus, action: viewModel.increaseTempo)
                        .brandFont(.title)
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
        .background(LinearGradient(.yellowGreen).edgesIgnoringSafeArea(.all))
        .foregroundColor(Palette.black.color)
    }


    // MARK: Private helper methods

    private func complete() {
        viewModel.commit()
        presentationMode.wrappedValue.dismiss()
    }
}


private struct PickerButton: View {

    private(set) var icon: SystemIcon
    private(set) var action: () -> ()

    var body: some View {
        Button(action: action) {
            ZStack {
                Color(Palette.white)
                    .opacity(0.2)
                    .cornerRadius(4)

                Image(icon)
            }
        }
        .frame(width: 46, height: 46)
    }
}


// MARK: Previews

struct TempoPickerView_Preview: PreviewProvider {

    static var previews: some View {
        let metronome = Metronome(with: .default, soundOn: false)
        let viewModel = TempoPickerViewModel(metronome: metronome)
        return TempoPickerView(viewModel: viewModel)
            .previewLayout(.fixed(width: 568, height: 320))
    }
}


struct PickerButton_Preview: PreviewProvider {

    static var previews: some View {
        return PickerButton(icon: .plus, action: {})
            .padding()
            .background(Palette.yellow.color)
            .previewLayout(.fixed(width: 200, height: 100))
    }
}
