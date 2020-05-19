//
//  AppDelegate.swift
//  Metronome Macos
//
//  Created by luca strazzullo on 28/4/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import Cocoa
import SwiftUI
import Combine

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!

    private var metronome: Metronome!
    private var metronomePublisher: MetronomePublisher!
    private var metronomeViewModel: MetronomeViewModel!

    private var cancellables: [AnyCancellable] = []


    // MARK: Public methods

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        metronome = Metronome(with: .default, soundOn: true)
        metronomePublisher = MetronomePublisher(metronome: metronome)
        metronomeViewModel = MetronomeViewModel(metronomePublisher: metronomePublisher)

        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 800, height: 600),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        window.center()
        window.setFrameAutosaveName("Main Window")
        window.contentView = NSHostingView(rootView: MetronomeView(viewModel: metronomeViewModel, metronome: metronome))
        window.makeKeyAndOrderFront(nil)
    }


    func applicationWillTerminate(_ aNotification: Notification) {
        metronome.reset()
    }
}

