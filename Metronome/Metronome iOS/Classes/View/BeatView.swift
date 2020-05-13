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
                self.draggedOffset = min(BeatView.togglerHeight, action.translation.height)
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
            BeatBackgroundView(state: state)

            VStack(alignment: .center, spacing: 84) {
                Image(systemName: SystemIcon.arrowDown.name)
                    .brandFont(.title1)
                    .foregroundColor(foregroundColor(for: state))

                Circle()
                    .frame(width: 8, height: 8, alignment: .center)
                    .foregroundColor(accentIndicatorColor(for: state))

                Text(label)
                    .brandFont(.headline)
                    .foregroundColor(foregroundColor(for: state))
            }
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
        case [.accented, .highlighted]:
            return Palette.purple.color
        case .accented:
            return Palette.white.color.opacity(0.19)
        default:
            return .clear
        }
    }
}


private struct BeatBackgroundView: View {

    private(set) var state: BeatViewModel.State

    var body: some View {
        let gradient = Gradient(colors: backgroundColors(for: state))
        let linearGradient = LinearGradient(gradient: gradient, startPoint: .topLeading, endPoint: .bottomTrailing)
        let view = AnyView(linearGradient)
            .cornerRadius(12, corners: [.bottomLeft, .bottomRight])
            .edgesIgnoringSafeArea(.all)

        return view
    }


    // MARK: Private helper methods

    private func backgroundColors(for state: BeatViewModel.State) -> [Color] {
        switch state {
        case .highlighted, [.highlighted, .accented]:
            return [Palette.green.color, Palette.blue.color]
        default:
            return [Palette.gray.color, Palette.gray.color]
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
                Image(systemName: iconName(for: state))
            }
            .brandFont(.footnote)
            .foregroundColor(foregroundColor(for: state))
        }
    }


    // MARK: Private helper methods

    private func iconName(for state: BeatViewModel.State) -> String {
        if state.contains(.accented) {
            return SystemIcon.on.name
        } else {
            return SystemIcon.off.name
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
