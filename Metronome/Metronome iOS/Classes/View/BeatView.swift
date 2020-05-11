//
//  BeatView.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 19/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI

struct BeatView: View {

    private static let draggedHeight: CGFloat = 100


    // MARK: Instance properties

    @ObservedObject private(set) var viewModel: BeatViewModel

    @State private var draggedOffset: CGFloat = -draggedHeight
    @State private var draggedLastOffset: CGFloat = -draggedHeight

    private let generator = UINotificationFeedbackGenerator()

    var body: some View {
        ZStack(alignment: .top) {
            ZStack(alignment: .center) {
                self.background().edgesIgnoringSafeArea(.all)
                VStack {
                    Text(viewModel.label ?? "")
                        .brandFont(.headline)
                        .foregroundColor(self.foreground())

                    Circle().frame(width: 8, height: 8, alignment: .center)
                        .foregroundColor(self.accentColor())
                }
            }
            VStack {
                ZStack(alignment: .bottom) {
                    self.accentTogglerBackgroundColor()
                        .edgesIgnoringSafeArea([.top])
                        .cornerRadius(4, corners: [.bottomLeft, .bottomRight])

                    VStack {
                        Text(Copy.Controls.accent.localised)
                            .brandFont(.footnote)
                            .foregroundColor(self.accentTogglerForegroundColor())
                            .padding(.bottom, 8)

                        Circle().frame(width: 8, height: 8, alignment: .center)
                            .foregroundColor(self.accentTogglerForegroundColor())
                            .padding(.bottom, 12)
                    }
                }
                    .frame(height: BeatView.draggedHeight)
                    .animation(.default)
                    .offset(y: draggedOffset)

                Image(systemName: SystemIcon.arrowDown.name)
                    .foregroundColor(self.foreground())
                    .font(.footnote)
                    .opacity(self.draggedOffset > -(BeatView.draggedHeight - 30) ? 0 : 1)
                    .offset(x: 0, y: self.draggedOffset > -(BeatView.draggedHeight - 30) ? 8 : 0)
                    .padding(.top, 8)
                    .animation(.default)
                    .offset(y: draggedOffset)
            }
        }
        .gesture(DragGesture()
            .onChanged { action in
                if self.draggedOffset > -(BeatView.draggedHeight/4), self.viewModel.isTemporaryValueSelected == false {
                    self.viewModel.toggleIsAccentTemporarely()
                    self.generator.notificationOccurred(.success)
                    self.draggedOffset = min(0, self.draggedLastOffset + action.translation.height)
                } else if self.draggedOffset < -(BeatView.draggedHeight/4), self.viewModel.isTemporaryValueSelected == true {
                    self.viewModel.discard()
                    self.generator.notificationOccurred(.warning)
                    self.draggedOffset = min(0, self.draggedLastOffset + action.translation.height)
                } else {
                    self.draggedOffset = min(0, self.draggedLastOffset + action.translation.height)
                }
            }
            .onEnded { action in
                self.viewModel.commit()
                self.draggedOffset = -BeatView.draggedHeight
                self.draggedLastOffset = self.draggedOffset
            })
    }


    // MARK: Private helper methods

    private func background() -> some View {
        if viewModel.isHighlighted {
            return LinearGradient(gradient: Gradient(colors: [Palette.green.color, Palette.blue.color]), startPoint: .topLeading, endPoint: .bottomTrailing)
        } else {
            return LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.05), Color.white.opacity(0.05)]), startPoint: .topLeading, endPoint: .bottomTrailing)
        }
    }


    private func foreground() -> Color {
        if viewModel.isHighlighted {
            return Palette.white.color
        } else {
            return Palette.gray.color
        }
    }


    private func accentColor() -> Color {
        switch true {
        case viewModel.isAccent && viewModel.isHighlighted:
            return Palette.purple.color
        case viewModel.isAccent:
            return Palette.gray.color
        default:
            return .clear
        }
    }


    private func accentTogglerBackgroundColor() -> Color {
        if viewModel.isAccent {
            return Palette.purple.color
        } else {
            return .clear
        }
    }


    private func accentTogglerForegroundColor() -> Color {
        if viewModel.isAccent {
            return Palette.white.color
        } else {
            return Palette.gray.color
        }
    }
}
