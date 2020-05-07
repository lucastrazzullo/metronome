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

    @State var viewModel: TimeSignaturePickerViewModel


    // MARK: Body

    var body: some View {
        ZStack(alignment: .leading) {
            Palette.orange.color.edgesIgnoringSafeArea(.all)

            HStack(alignment: .center, spacing: 80) {
                HStack(alignment: .center) {
                    Text(Copy.TimeSignature.title.localised).brandFont(.headline)
                }

                HStack(alignment: .center, spacing: 0) {
                    VStack {
                        Picker(selection: self.$viewModel.selectedBarLength, label: Text(Copy.TimeSignature.barLength.localised).padding(2)) {
                            ForEach(viewModel.barLengthItems, id: \.self) { length in
                                Text(String(length)).font(.title)
                            }
                        }
                    }
                    .frame(width: 100, height: nil, alignment: .center)
                    .clipped()

                    VStack {
                        Picker(selection: self.$viewModel.selectedNoteLength, label: Text(Copy.TimeSignature.noteLength.localised).padding(2)) {
                            ForEach(viewModel.noteLengthItems, id: \.self) { length in
                                Text(String(length)).font(.title)
                            }
                        }
                    }
                    .frame(width: 100, height: nil, alignment: .center)
                    .clipped()
                }
                .labelsHidden()

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
            .foregroundColor(Palette.black.color)
            .padding()
        }
    }
}
