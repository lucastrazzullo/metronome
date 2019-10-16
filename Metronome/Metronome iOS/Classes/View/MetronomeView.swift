//
//  MetronomeView.swift
//  Metronome
//
//  Created by luca strazzullo on 30/9/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI
import Combine

struct MetronomeView: View {

    @ObservedObject var observed: ObservableMetronome<MetronomeViewModel>


    // MARK: Body

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            HStack(alignment: .center, spacing: 1) {
                ForEach(observed.snapshot.bits, id: \.index) { bitViewModel in
                    ZStack {
                        self.background(for: bitViewModel.index).edgesIgnoringSafeArea(.all)
                        Text(String(bitViewModel.label)).brandFont(.headline)
                    }.foregroundColor(self.foregroundColor(forBitAt: bitViewModel.index))
                }
            }
        }
    }


    // MARK: Private helper methods

    private func background(for index: Int) -> some View {
        if observed.snapshot.isRunning, observed.snapshot.currentBitIndex == index {
            return LinearGradient(gradient: Gradient(colors: [Color("green"), Color("blue")]), startPoint: .topLeading, endPoint: .bottomTrailing)
        } else {
            return LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.05), Color.white.opacity(0.05)]), startPoint: .topLeading, endPoint: .bottomTrailing)
        }
    }


    private func foregroundColor(forBitAt index: Int) -> Color {
        if observed.snapshot.isRunning, observed.snapshot.currentBitIndex == index {
            return Color.white
        } else {
            return Color.white.opacity(0.1)
        }
    }
}
