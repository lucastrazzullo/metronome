//
//  TimeSignaturePickerView.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 6/5/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import SwiftUI
import Combine

struct TimeSignaturePickerView: View {

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @ObservedObject var viewModel: TimeSignaturePickerViewModel


    // MARK: Body

    var body: some View {
        ZStack(alignment: .leading) {
            VStack(alignment: .center, spacing: 12) {
                Text(Copy.TimeSignature.title.localised).brandFont(.title)

                Spacer()

                VStack(alignment: .center, spacing: 24) {

                    VStack(alignment: .center, spacing: 8) {
                        Text(Copy.TimeSignature.barLength.localised)
                            .brandFont(.callout)
                            .opacity(0.36)

                        HStack(alignment: .center, spacing: 28) {
                            PickerButton(icon: .minus, action: viewModel.decreaseBarLength)
                                .brandFont(.title)

                            HStack(alignment: .center, spacing: 8) {
                                ForEach(viewModel.barLengthItems, id: \.position) { item in
                                    Button(action: { self.viewModel.toggleIsAccent(at: item.position) }) {
                                        VStack(alignment: .center, spacing: 4) {
                                            Text(String(item.position + 1))
                                                .brandFont(.subheadline)

                                            Circle()
                                                .frame(width: 4, height: 4, alignment: .center)
                                                .foregroundColor(Palette.purple.color)
                                                .opacity(self.accentIndicatorOpacity(at: item.position))
                                        }
                                        .padding([.bottom, .leading, .trailing], 12)
                                        .padding(.top, 4)
                                        .background(Palette.white.color.opacity(self.opacity(forBeatAt: item.position)))
                                        .cornerRadius(4)
                                    }
                                }
                            }

                            PickerButton(icon: .plus, action: viewModel.increaseBarLength)
                                .brandFont(.title)
                        }
                    }

                    VStack(alignment: .center, spacing: 8) {
                        Text(Copy.TimeSignature.noteLength.localised)
                            .brandFont(.callout)
                            .opacity(0.36)

                        HStack(alignment: .center, spacing: 12) {
                            ForEach(viewModel.noteLengthItems, id: \.self) { length in
                                Button(action: { self.viewModel.selectNoteLength(length.rawValue) }) {
                                    Text(String(length.rawValue))
                                        .brandFont(.subheadline)
                                        .padding([.top, .bottom], 8)
                                        .padding([.leading, .trailing], 12)
                                        .background(Palette.white.color.opacity(self.opacity(forNoteWith: length.rawValue)))
                                        .cornerRadius(4)
                                }
                            }
                        }
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
            .foregroundColor(Palette.black.color)
            .padding()
        }
        .padding(.top, 12)
        .padding([.bottom, .leading, .trailing], 4)
        .background(LinearGradient(.orangePink).edgesIgnoringSafeArea(.all))
        .foregroundColor(Palette.black.color)
    }


    // MARK: Private helper methods

    private func complete() {
        viewModel.commit()
        presentationMode.wrappedValue.dismiss()
    }


    private func accentIndicatorOpacity(at position: Int) -> Double {
        return viewModel.selectedAccentPositions.contains(position) ? 1 : 0
    }


    private func opacity(forBeatAt position: Int) -> Double {
        return viewModel.selectedBarLength > position ? 1 : 0.2
    }


    private func opacity(forNoteWith length: Int) -> Double {
        return viewModel.selectedNoteLength == length ? 1 : 0.2
    }
}


// MARK: Previews

struct TimeSignaturePickerView_Preview: PreviewProvider {

    static var previews: some View {
        let metronome = Metronome(with: .default, soundOn: false)
        let viewModel = TimeSignaturePickerViewModel(metronome: metronome)
        return TimeSignaturePickerView(viewModel: viewModel)
            .previewLayout(.fixed(width: 568, height: 340))
    }
}
