//
//  BeatView.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 19/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI

struct BeatView: View {

    private static let togglerHeight: CGFloat = 60
    private static let togglerTreshold: CGFloat = 30


    // MARK: Instance properties

    @ObservedObject private(set) var viewModel: BeatViewModel

    @State private var draggedOffset: CGFloat = 0

    private let hapticFeedbackGenerator = UINotificationFeedbackGenerator()

    var body: some View {
        ZStack(alignment: .top) {
            BeatAccentTogglerView(state: viewModel.state)
                .frame(height: draggedOffset)

            BeatCardView(label: viewModel.label, state: viewModel.state)
                .offset(y: draggedOffset)
        }
        .animation(.default)
        .gesture(DragGesture()
            .onChanged { action in
                self.draggedOffset = min(BeatView.togglerHeight, max(12, action.translation.height))
                if self.draggedOffset > BeatView.togglerTreshold, self.viewModel.isTemporaryValueSelected == false {
                    self.viewModel.toggleIsAccentTemporarely()
                    self.hapticFeedbackGenerator.notificationOccurred(.success)
                } else if self.draggedOffset < BeatView.togglerTreshold, self.viewModel.isTemporaryValueSelected == true {
                    self.viewModel.discard()
                    self.hapticFeedbackGenerator.notificationOccurred(.warning)
                }
            }
            .onEnded { action in
                self.viewModel.commit()
                self.draggedOffset = 0
            })
    }
}


private struct BeatCardView: View {

    private(set) var label: String
    private(set) var state: BeatViewModel.State

    var body: some View {
        ZStack(alignment: .center) {
            LinearGradient(backgroundGradient(for: state))
                .cornerRadius(12, corners: [.bottomLeft, .bottomRight])
                .edgesIgnoringSafeArea(.all)
                .shadow(color: Palette.black.color.opacity(0.45), radius: 2, x: 0, y: -2)

            Text(label)
                .brandFont(.largeTitle)
                .foregroundColor(foregroundColor(for: state))

            VStack(alignment: .center, spacing: 24) {
                Image(SystemIcon.arrowDown)
                    .brandFont(.title)
                    .foregroundColor(foregroundColor(for: state))

                Circle()
                    .frame(width: 8, height: 8, alignment: .center)
                    .foregroundColor(accentIndicatorColor(for: state))

                Spacer()
            }
            .padding(.top, 32)
        }
    }


    // MARK: Private helper methods

    private func foregroundColor(for state: BeatViewModel.State) -> Color {
        switch state {
        case .highlighted, [.highlighted, .accented]:
            return Palette.white.color
        default:
            return Palette.white.color.opacity(0.19)
        }
    }


    private func accentIndicatorColor(for state: BeatViewModel.State) -> Color {
        switch state {
        case [.accented, .highlighted], .accented:
            return Palette.purple.color
        default:
            return .clear
        }
    }


    private func backgroundGradient(for state: BeatViewModel.State) -> Palette.Gradients {
        switch state {
        case .highlighted, [.highlighted, .accented]:
            return .blueGreen
        default:
            return .gray
        }
    }
}


private struct BeatAccentTogglerView: View {

    private(set) var state: BeatViewModel.State

    var body: some View {
        ZStack(alignment: .center) {
            Color(backgroundPalette(for: state))
                .edgesIgnoringSafeArea(.all)

            HStack(alignment: .center, spacing: 4) {
                Text(Copy.TimeSignature.Beat.accent.localised)
                Image(icon(for: state))
            }
            .brandFont(.footnote)
            .foregroundColor(foregroundColor(for: state))
        }
    }


    // MARK: Private helper methods

    private func icon(for state: BeatViewModel.State) -> SystemIcon {
        if state.contains(.accented) {
            return SystemIcon.on
        } else {
            return SystemIcon.off
        }
    }


    private func backgroundPalette(for state: BeatViewModel.State) -> Palette {
        if state.contains(.accented) {
            return Palette.purple
        } else {
            return Palette.black
        }
    }


    private func foregroundColor(for state: BeatViewModel.State) -> Color {
        if state.contains(.accented) {
            return Palette.white.color
        } else {
            return Palette.white.color.opacity(0.8)
        }
    }
}
