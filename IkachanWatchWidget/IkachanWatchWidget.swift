import WidgetKit
import SwiftUI

struct Splatoon2ScheduleWidget: Widget {
    let kind = "Splatoon2ScheduleWidget"
    
    var supportedFamilies: [WidgetFamily] {
        return [.accessoryRectangular]
    }

    var body: some WidgetConfiguration {
        return IntentConfiguration(kind: kind, intent: Splatoon2ScheduleIntent.self, provider: Splatoon2ScheduleProvider()) { entry in
            Splatoon2ScheduleView(entry: entry)
        }
        .configurationDisplayName("splatoon_2_schedule")
        .description("splatoon_2_schedule_widget_description")
        .supportedFamilies(supportedFamilies)
    }
}

struct Splatoon2ShiftWidget: Widget {
    let kind = "Splatoon2ShiftWidget"
    
    var supportedFamilies: [WidgetFamily] {
        return [.accessoryRectangular]
    }

    var body: some WidgetConfiguration {
        return IntentConfiguration(kind: kind, intent: Splatoon2ShiftIntent.self, provider: Splatoon2ShiftProvider()) { entry in
            Splatoon2ShiftView(entry: entry)
        }
        .configurationDisplayName("splatoon_2_shift")
        .description("splatoon_2_shift_widget_description")
        .supportedFamilies(supportedFamilies)
    }
}

struct Splatoon3ScheduleWidget: Widget {
    let kind = "Splatoon3ScheduleWidget"
    
    var supportedFamilies: [WidgetFamily] {
        return [.accessoryRectangular]
    }

    var body: some WidgetConfiguration {
        return IntentConfiguration(kind: kind, intent: Splatoon3ScheduleIntent.self, provider: Splatoon3ScheduleProvider()) { entry in
            Splatoon3ScheduleView(entry: entry)
        }
        .configurationDisplayName("splatoon_3_schedule")
        .description("splatoon_3_schedule_widget_description")
        .supportedFamilies(supportedFamilies)
    }
}

struct Splatoon3ShiftWidget: Widget {
    let kind = "Splatoon3ShiftWidget"
    
    var supportedFamilies: [WidgetFamily] {
        return [.accessoryRectangular]
    }

    var body: some WidgetConfiguration {
        return IntentConfiguration(kind: kind, intent: Splatoon3ShiftIntent.self, provider: Splatoon3ShiftProvider()) { entry in
            Splatoon3ShiftView(entry: entry)
        }
        .configurationDisplayName("splatoon_3_shift")
        .description("splatoon_3_shift_widget_description")
        .supportedFamilies(supportedFamilies)
    }
}

struct Splatoon2ScheduleProgressWidget: Widget {
    let kind = "Splatoon2ScheduleDynamicWidget"

    var body: some WidgetConfiguration {
        return IntentConfiguration(kind: kind, intent: Splatoon2ScheduleIntent.self, provider: Splatoon2ScheduleProgressProvider()) { entry in
            Splatoon2ScheduleProgressView(entry: entry)
        }
        .configurationDisplayName("splatoon_2_schedule")
        .description("splatoon_2_schedule_widget_description")
        .supportedFamilies([.accessoryCircular, .accessoryCorner])
    }
}

struct Splatoon2ShiftProgressWidget: Widget {
    let kind = "Splatoon2ShiftDynamicWidget"

    var body: some WidgetConfiguration {
        return IntentConfiguration(kind: kind, intent: Splatoon2ShiftIntent.self, provider: Splatoon2ShiftProgressProvider()) { entry in
            Splatoon2ShiftProgressView(entry: entry)
        }
        .configurationDisplayName("splatoon_2_shift")
        .description("splatoon_2_shift_widget_description")
        .supportedFamilies([.accessoryCircular, .accessoryCorner])
    }
}

struct Splatoon3ScheduleProgressWidget: Widget {
    let kind = "Splatoon3ScheduleDynamicWidget"

    var body: some WidgetConfiguration {
        return IntentConfiguration(kind: kind, intent: Splatoon3ScheduleIntent.self, provider: Splatoon3ScheduleProgressProvider()) { entry in
            Splatoon3ScheduleProgressView(entry: entry)
        }
        .configurationDisplayName("splatoon_3_schedule")
        .description("splatoon_3_schedule_widget_description")
        .supportedFamilies([.accessoryCircular, .accessoryCorner])
    }
}

struct Splatoon3ShiftProgressWidget: Widget {
    let kind = "Splatoon3ShiftDynamicWidget"

    var body: some WidgetConfiguration {
        return IntentConfiguration(kind: kind, intent: Splatoon3ShiftIntent.self, provider: Splatoon3ShiftProgressProvider()) { entry in
            Splatoon3ShiftProgressView(entry: entry)
        }
        .configurationDisplayName("splatoon_3_shift")
        .description("splatoon_3_shift_widget_description")
        .supportedFamilies([.accessoryCircular, .accessoryCorner])
    }
}
