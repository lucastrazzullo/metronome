//
//  AppDelegate.swift
//  Metronome Macos
//
//  Created by luca strazzullo on 28/4/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import Cocoa
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!

    private var metronome: MetronomeController!
    private var metronomePublisher: MetronomeStatePublisher!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let configuration = MetronomeConfiguration(timeSignature: .default, tempo: .default)
        metronome = MetronomeController(with: configuration)
        metronomePublisher = MetronomeStatePublisher(metronome: metronome)

        let model = MetronomeViewModel(snapshot: metronomePublisher.snapshot())
        let contentView = MetronomeView(metronome: metronome, model: model)

        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        window.center()
        window.setFrameAutosaveName("Main Window")
        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(nil)
    }


    func applicationWillTerminate(_ aNotification: Notification) {
        metronome.reset()
    }
}

