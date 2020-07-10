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
        let timeSignature = controller.session?.configuration.timeSignature ?? TimeSignature.default

        let template: CLKComplicationTemplate
        switch complication.family {
        case .circularSmall:
            template = buildCircularSmallTemplate(for: tempo)
        case .modularSmall:
            template = buildModularSmallTemplate(for: tempo)
        case .modularLarge:
            template = buildModularLargeTemplate(for: tempo, timeSignature: timeSignature)
        case .graphicCorner:
            template = buildGraphicCornerTemplate(for: tempo)
        default:
            template = buildModularSmallTemplate(for: tempo)
        }

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
        switch complication.family {
        case .circularSmall:
            handler(buildCircularSmallTemplate(for: .default))
        case .modularSmall:
            handler(buildModularSmallTemplate(for: .default))
        case .modularLarge:
            handler(buildModularLargeTemplate(for: .default, timeSignature: .default))
        case .graphicCorner:
            handler(buildGraphicCornerTemplate(for: .default))
        default:
            handler(buildModularSmallTemplate(for: .default))
        }
    }


    // MARK: - Private helper methods

    private func buildCircularSmallTemplate(for tempo: Tempo) -> CLKComplicationTemplate {
        let template = CLKComplicationTemplateCircularSmallRingText()
        template.fillFraction = fillFraction(for: tempo)
        template.textProvider = CLKSimpleTextProvider(text: String(tempo.bpm))
        return template
    }


    private func buildModularSmallTemplate(for tempo: Tempo) -> CLKComplicationTemplate {
        let template = CLKComplicationTemplateModularSmallStackText()
        template.line1TextProvider = CLKSimpleTextProvider(text: String(tempo.bpm))
        template.line2TextProvider = CLKSimpleTextProvider(text: Copy.Tempo.unit.localised)
        return template
    }


    private func buildModularLargeTemplate(for tempo: Tempo, timeSignature: TimeSignature) -> CLKComplicationTemplate {
        let template = CLKComplicationTemplateModularLargeTable()
        template.headerTextProvider = CLKSimpleTextProvider(text: "Metronome")
        template.row1Column1TextProvider = CLKSimpleTextProvider(text: Copy.Tempo.title.localised)
        template.row1Column2TextProvider = CLKSimpleTextProvider(format: Copy.Tempo.format.localised, tempo.bpm, Copy.Tempo.unit.localised)
        template.row2Column1TextProvider = CLKSimpleTextProvider(text: Copy.TimeSignature.titleShort.localised)
        template.row2Column2TextProvider = CLKSimpleTextProvider(format: Copy.TimeSignature.format.localised, timeSignature.barLength.numberOfBeats, timeSignature.noteLength.rawValue)
        return template
    }


    private func buildGraphicCornerTemplate(for tempo: Tempo) -> CLKComplicationTemplate {
        let template = CLKComplicationTemplateGraphicCornerGaugeText()
        template.outerTextProvider = CLKSimpleTextProvider(text: Copy.Tempo.unit.localised)
        template.leadingTextProvider = CLKSimpleTextProvider(text: String(tempo.bpm))
        template.gaugeProvider = CLKSimpleGaugeProvider(style: .fill, gaugeColor: .yellow, fillFraction: fillFraction(for: tempo))
        return template
    }


    private func fillFraction(for tempo: Tempo) -> Float {
        Float(Double(tempo.bpm) / Double(Tempo.range.upperBound - Tempo.range.lowerBound))
    }
}
