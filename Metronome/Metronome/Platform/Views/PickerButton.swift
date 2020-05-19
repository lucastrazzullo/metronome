//
//  PickerButton.swift
//  Metronome CocoaTests
//
//  Created by luca strazzullo on 14/5/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import SwiftUI
import Combine

struct PickerButton: View {

    @State private var cancellable: Cancellable?
    @State private var timer = PickerButton.buildTimerPublisher(with: PickerButton.defaultTimeInterval())
    @State private var timerInterval = PickerButton.defaultTimeInterval()

    private(set) var icon: SystemIcon
    private(set) var action: () -> ()

    var body: some View {
        ZStack {
            Color(Palette.white)
                .opacity(0.2)
                .cornerRadius(4)

            Image(icon)
        }
        .frame(width: 46, height: 46)
        .gesture(TapGesture()
            .onEnded({
                self.cancellable?.cancel()
                self.timerInterval = PickerButton.defaultTimeInterval()
                self.timer = PickerButton.buildTimerPublisher(with: self.timerInterval)
                self.action()
            })
        )
        .gesture(LongPressGesture()
            .onEnded({ _ in
                self.action()
                self.cancellable = self.timer.connect()
            })
            .simultaneously(with: DragGesture())
            .sequenced(before: TapGesture()
                .onEnded({ _ in
                    self.cancellable?.cancel()
                    self.timerInterval = PickerButton.defaultTimeInterval()
                    self.timer = PickerButton.buildTimerPublisher(with: self.timerInterval)
                })
        ))
        .onReceive(timer, perform: { _ in
            self.timerInterval -= PickerButton.incrementTimeInterval()
            self.timer = PickerButton.buildTimerPublisher(with: self.timerInterval)
            self.cancellable = self.timer.connect()
            self.action()
        })
    }


    // MARK: Private helper methods

    private static func buildTimerPublisher(with interval: TimeInterval) -> Timer.TimerPublisher {
        let interval = max(minimumTimeInterval(), interval)
        return Timer.publish(every: interval, on: .main, in: RunLoop.Mode.common)
    }


    private static func defaultTimeInterval() -> TimeInterval {
        return 0.2
    }


    private static func minimumTimeInterval() -> TimeInterval {
        return 0.02
    }


    private static func incrementTimeInterval() -> TimeInterval {
        return 0.02
    }
}


// MARK: Previews

struct PickerButton_Preview: PreviewProvider {

    static var previews: some View {
        return PickerButton(icon: .plus, action: {})
            .padding()
            .background(Palette.yellow.color)
            .previewLayout(.fixed(width: 200, height: 100))
    }
}
