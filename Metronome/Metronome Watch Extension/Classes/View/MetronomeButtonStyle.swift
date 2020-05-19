//
//  MetronomeButtonStyle.swift
//  Metronome CocoaTests
//
//  Created by luca strazzullo on 19/5/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import SwiftUI

struct MetronomeButtonStyle: ButtonStyle {

    private(set) var highlighted: Bool
    private(set) var background: ShapeIllustration

    func makeBody(configuration: Self.Configuration) -> some View {
        ZStack {
            configuration.label
                .font(Font.system(.body).weight(.bold))
                .foregroundColor(.white)
                .padding(12)
        }
        .background(Image(background)
            .resizable()
            .renderingMode(highlighted ? .original : .template)
            .foregroundColor(Palette.gray.color)
        )
    }
}


struct MetronomeButtonStyle_Previews: PreviewProvider {

    static var previews: some View {
        Button(action: {}) {
            Text("Hello, World!")
        }.buttonStyle(MetronomeButtonStyle(highlighted: true, background: .button1))
    }
}
