//
//  ShapedButton.swift
//  Metronome CocoaTests
//
//  Created by luca strazzullo on 24/5/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import SwiftUI

struct ShapedButtonStyle: ButtonStyle {

    private(set) var highlighted: Bool
    private(set) var shape: ShapeIllustration

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .fixedSize()
            .padding(.horizontal, 18)
            .padding(.vertical, 12)

            .foregroundColor(highlighted ? Palette.white.color : Palette.white.color.opacity(0.29))
            .background(Image(shape)
                .resizable()
                .renderingMode(highlighted ? .original : .template)
                .foregroundColor(Palette.gray.color)
            )

            .frame(minHeight: 44, idealHeight: 44, maxHeight: 44, alignment: .center)
    }
}


struct ShapedButtonStyle_Previews: PreviewProvider {

    static var previews: some View {
        Button(action: {}) {
            Text("Hello, World!")
        }.buttonStyle(ShapedButtonStyle(highlighted: true, shape: .button1))
    }
}
