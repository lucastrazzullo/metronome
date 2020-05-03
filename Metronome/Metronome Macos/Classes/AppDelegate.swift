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

    private var metronome: MetronomeController!
    private var metronomePublisher: MetronomeStatePublisher!
    private var metronomeViewModel: MetronomeViewModel!

    private var cancellables: [AnyCancellable] = []


    // MARK: Public methods

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        metronome = MetronomeController(with: .default)
        metronomePublisher = MetronomeStatePublisher(metronome: metronome)
        metronomeViewModel = MetronomeViewModel(metronomePublisher: metronomePublisher)

        let view = MetronomeView().environmentObject(metronomeViewModel)
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        window.center()
        window.setFrameAutosaveName("Main Window")
        window.contentView = NSHostingView(rootView: view)
        window.makeKeyAndOrderFront(nil)
    }


    func applicationWillTerminate(_ aNotification: Notification) {
        metronome.reset()
    }
}

