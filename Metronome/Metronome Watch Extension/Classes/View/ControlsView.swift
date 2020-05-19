//
//  ControlsView.swift
//  Metronome Watch Extension
//
//  Created by luca strazzullo on 6/5/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import SwiftUI

struct ControlsView: View {

    struct CornerRoundedButtonStyle: ButtonStyle {
        let background: Color

        func makeBody(configuration: Self.Configuration) -> some View {
            configuration.label
                .padding()
                .background(background)
                .cornerRadius(8)
        }
    }


    // MARK: Instance properties

    @ObservedObject private(set) var viewModel: ControlsViewModel

    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            HStack(alignment: .center, spacing: 8) {
                NavigationLink(destination: TimeSignaturePickerView(viewModel: viewModel.timeSignaturePickerViewModel())) {
                    Text(viewModel.timeSignatureLabel).font(Font.system(.footnote))
                }
                .buttonStyle(CornerRoundedButtonStyle(background: self.viewModel.timeSignatureColor.color))

                NavigationLink(destination: TempoPickerView(viewModel: viewModel.tempoPickerViewModel())) {
                    Text(viewModel.tempoLabel).font(Font.system(.footnote))
                }
                .buttonStyle(CornerRoundedButtonStyle(background: self.viewModel.tempoColor.color))
            }
            .fixedSize(horizontal: true, vertical: false)
            .foregroundColor(Color.black.opacity(0.7))

            HStack(alignment: .center, spacing: 24) {
                Button(action: { self.viewModel.toggleIsRunning() }, label: {
                    return Text(viewModel.togglerLabel)
                })
            }
            .foregroundColor(Color.white.opacity(0.7))
        }
    }
}
