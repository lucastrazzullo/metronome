//
//  SessionComplicationController.swift
//  Metronome Watch Extension
//
//  Created by luca strazzullo on 5/6/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import WatchKit
import ClockKit

class SessionComplicationController: NSObject, CLKComplicationDataSource {

    private var controller: SessionController {
        return (WKExtension.shared().delegate as! ExtensionDelegate).sessionController
    }


    // MARK: - Timeline Configuration

    func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        handler([])
    }

    func getTimelineStartDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(nil)
    }

    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(nil)
    }

    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.showOnLockScreen)
    }

    // MARK: - Timeline Population

    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        let tempo = controller.session?.configuration.tempo ?? Tempo.default

        let template = CLKComplicationTemplateModularSmallStackText()
        template.line1TextProvider = CLKSimpleTextProvider(text: String(tempo.bpm))
        template.line2TextProvider = CLKSimpleTextProvider(text: Copy.Tempo.unit.localised)

        let entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
        handler(entry)
    }

    func getTimelineEntries(for complication: CLKComplication, before date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        handler(nil)
    }

    func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        handler(nil)
    }

    // MARK: - Placeholder Templates

    func getPlaceholderTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        let tempo = Tempo(bpm: 120)
        let template = CLKComplicationTemplateModularSmallStackText()
        template.line1TextProvider = CLKSimpleTextProvider(text: String(tempo.bpm))
        template.line2TextProvider = CLKSimpleTextProvider(text: Copy.Tempo.unit.localised)
        handler(template)
    }
}
