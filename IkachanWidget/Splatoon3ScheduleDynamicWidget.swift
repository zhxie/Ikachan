//
//  Splatoon3ScheduleDynamicWidget.swift
//  IkachanWidget
//
//  Created by Sketch on 2023/12/14.
//

import WidgetKit
import SwiftUI
import Intents

struct Splatoon3ScheduleDynamicProvider: IntentTimelineProvider {
    func filterSchedules(schedules: [Splatoon3Schedule], mode: INSplatoon3ScheduleMode) -> [Splatoon3Schedule] {
        return schedules.filter { schedule in
            switch mode {
            case .unknown, .regularBattle:
                return schedule._mode == .regularBattle
            case .anarchyBattleSeries:
                return schedule._mode == .anarchyBattleSeries
            case .anarchyBattleOpen:
                return schedule._mode == .anarchyBattleOpen
            case .xBattle:
                return schedule._mode == .xBattle
            case .challenges:
                return schedule._mode == .challenges
            case .splatfestBattleOpen:
                return schedule._mode == .splatfestBattleOpen
            case .splatfestBattlePro:
                return schedule._mode == .splatfestBattlePro
            case .tricolorBattle:
                return schedule._mode == .tricolorBattle
            }
        }.filter { schedule in
            schedule.endTime > Date()
        }
    }
    
    func placeholder(in context: Context) -> Splatoon3ScheduleDynamicEntry {
        Splatoon3ScheduleDynamicEntry(date: Date(), configuration: Splatoon3ScheduleIntent(), schedule: PreviewSplatoon3Schedule)
    }

    func getSnapshot(for configuration: Splatoon3ScheduleIntent, in context: Context, completion: @escaping (Splatoon3ScheduleDynamicEntry) -> ()) {
        fetchSplatoon3Schedules(locale: Locale.localizedLocale) { schedules, error in
            guard error == .NoError else {
                completion(Splatoon3ScheduleDynamicEntry(date: Date(), configuration: configuration, schedule: nil))
                
                return
            }
            
            let filtered = filterSchedules(schedules: schedules, mode: configuration.mode)
            if !filtered.isEmpty {
                completion(Splatoon3ScheduleDynamicEntry(date: Date(), configuration: configuration, schedule: filtered.first!))
            } else {
                completion(Splatoon3ScheduleDynamicEntry(date: Date(), configuration: configuration, schedule: nil))
            }
        }
    }

    func getTimeline(for configuration: Splatoon3ScheduleIntent, in context: Context, completion: @escaping (Timeline<Splatoon3ScheduleDynamicEntry>) -> ()) {
        fetchSplatoon3Schedules(locale: Locale.localizedLocale) { schedules, error in
            guard error == .NoError else {
                completion(Timeline(entries: [Splatoon3ScheduleDynamicEntry(date: Date(), configuration: configuration, schedule: nil)], policy: .after(Date().addingTimeInterval(300))))
                
                return
            }
            
            var entries: [Splatoon3ScheduleDynamicEntry] = []
            let filtered = filterSchedules(schedules: schedules, mode: configuration.mode)
            if !filtered.isEmpty {
                var current = Date().floorToMin()
                for schedule in filtered {
                    while current < schedule.endTime && entries.count < MaxDynamicWidgetEntryCount {
                        let entry = Splatoon3ScheduleDynamicEntry(date: current, configuration: configuration, schedule: schedule)
                        entries.append(entry)
                        
                        current = current.addingTimeInterval(60)
                    }
                }
                
                completion(Timeline(entries: entries, policy: .atEnd))
            } else {
                completion(Timeline(entries: [Splatoon3ScheduleDynamicEntry(date: Date(), configuration: configuration, schedule: nil)], policy: .after(Date().addingTimeInterval(300))))
            }
        }
    }
}

struct Splatoon3ScheduleDynamicEntry: TimelineEntry {
    var date: Date
    var configuration: Splatoon3ScheduleIntent

    var schedule: Splatoon3Schedule?
}

@available(iOSApplicationExtension 16.0, *)
struct Splatoon3ScheduleDynamicWidgetEntryView : View {
    var entry: Splatoon3ScheduleDynamicProvider.Entry
    
    @Environment(\.widgetFamily) var family

    @ViewBuilder
    var body: some View {
        if #available(iOSApplicationExtension 17.0, *) {
            AccessoryCircularView(progress: timePassingBy(current: entry.date, start: entry.schedule?.startTime ?? entry.date, end: entry.schedule?.endTime ?? entry.date), mode: entry.schedule?.mode.image ?? nil, rule: entry.schedule?.rule.image ?? nil)
                .containerBackground(for: .widget, content: {})
        } else {
            AccessoryCircularView(progress: timePassingBy(current: entry.date, start: entry.schedule?.startTime ?? entry.date, end: entry.schedule?.endTime ?? entry.date), mode: entry.schedule?.mode.image ?? nil, rule: entry.schedule?.rule.image ?? nil)
        }
    }
}

@available(iOSApplicationExtension 16.0, *)
struct Splatoon3ScheduleDynamicWidget: Widget {
    let kind = "Splatoon3ScheduleDynamicWidget"

    var body: some WidgetConfiguration {
        return IntentConfiguration(kind: kind, intent: Splatoon3ScheduleIntent.self, provider: Splatoon3ScheduleDynamicProvider()) { entry in
            Splatoon3ScheduleDynamicWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("splatoon_3_schedule")
        .description("splatoon_3_schedule_widget_description")
        .supportedFamilies([.accessoryCircular])
    }
}

@available(iOSApplicationExtension 16.0, *)
struct Splatoon3ScheduleDynamicWidgetEntryView_Previews: PreviewProvider {
    static var previews: some View {
        Splatoon3ScheduleDynamicWidgetEntryView(entry: Splatoon3ScheduleDynamicEntry(date: Date(), configuration: Splatoon3ScheduleIntent(), schedule: PreviewSplatoon3Schedule))
            .previewContext(WidgetPreviewContext(family: .accessoryCircular))
    }
}
