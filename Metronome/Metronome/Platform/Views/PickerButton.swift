//
//  PickerButton.swift
//  Metronome CocoaTests
//
//  Created by luca strazzullo on 14/5/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import SwiftUI

struct PickerButton: View {

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

struct PickerButton_Preview: PreviewProvider {

    static var previews: some View {
        return PickerButton(icon: .plus, action: {})
            .padding()
            .background(Palette.yellow.color)
            .previewLayout(.fixed(width: 200, height: 100))
    }
}
