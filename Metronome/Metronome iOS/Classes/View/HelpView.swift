//
//  HelpView.swift
//  Metronome
//
//  Created by luca strazzullo on 6/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI

struct HelpView: View {

    var model: HelpViewModel

    var body: some View {        
        ZStack {
            Color.white.opacity(0.9).edgesIgnoringSafeArea(.all)
            VStack(alignment: .center, spacing: 40) {
                Text(model.titleLabel).font(Font.system(.title))
                HStack(alignment: .top, spacing: 60) {
                    ForEach(model.tips, id: \.self) { tipViewModel in
                        VStack(alignment: .center, spacing: 40) {
                            Image(tipViewModel.illustration).frame(width: 90, height: 90, alignment: .center)
                            VStack(alignment: .leading, spacing: 8) {
                                Text(tipViewModel.title).multilineTextAlignment(.leading).font(Font.system(.headline))
                                Text(tipViewModel.description).multilineTextAlignment(.leading).font(Font.system(.callout))
                            }
                        }
                    }
                }
            }
        }
    }
}
