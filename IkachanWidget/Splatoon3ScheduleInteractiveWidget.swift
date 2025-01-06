import WidgetKit
import SwiftUI
import Intents
import Kingfisher
import AppIntents

struct Splatoon3ScheduleInteractiveProvider: TimelineProvider {
    func filterSchedules(schedules: [Splatoon3Schedule], mode: Splatoon3ScheduleMode) -> [Splatoon3Schedule] {
        return schedules.filter { schedule in
            schedule._mode == mode
        }.filter { schedule in
            schedule.endTime > Date()
        }
    }
    
    func placeholder(in context: Context) -> Splatoon3ScheduleInteractiveEntry {
        Splatoon3ScheduleInteractiveEntry(date: Date(), schedules: [PreviewSplatoon3Schedule, PreviewSplatoon3Schedule, PreviewSplatoon3Schedule], nextSchedules: [PreviewSplatoon3Schedule, PreviewSplatoon3Schedule, PreviewSplatoon3Schedule])
    }
    
    func getSnapshot(in context: Context, completion: @escaping (Splatoon3ScheduleInteractiveEntry) -> ()) {
        fetchSplatoon3Schedules(locale: Locale.localizedLocale) { schedules, error in
            guard error == .NoError else {
                completion(Splatoon3ScheduleInteractiveEntry(date: Date(), schedules: [nil, nil, nil, nil], nextSchedules: [nil, nil, nil, nil]))
                
                return
            }
            
            let regularFiltered = filterSchedules(schedules: schedules, mode: .regularBattle)
            let anarchySeriesFiltered = filterSchedules(schedules: schedules, mode: .anarchyBattleSeries)
            let anarchyOpenFiltered = filterSchedules(schedules: schedules, mode: .anarchyBattleOpen)
            let xFiltered = filterSchedules(schedules: schedules, mode: .xBattle)
            // HACK: Assume they have the same length.
            if !regularFiltered.isEmpty {
                let entry = Splatoon3ScheduleInteractiveEntry(date: Date(), schedules: [regularFiltered.first!, anarchySeriesFiltered.first!, anarchyOpenFiltered.first!, xFiltered.first!], nextSchedules: [regularFiltered.at(index: 1), anarchySeriesFiltered.at(index: 1), anarchyOpenFiltered.at(index: 1), xFiltered.at(index: 1)])
                var urls: Set<URL> = []
                for stage in [regularFiltered.first!.stages, anarchySeriesFiltered.first!.stages, anarchyOpenFiltered.first!.stages, xFiltered.first!.stages].flatMap({ $0 }) {
                    urls.insert(stage.thumbnail ?? stage.image)
                }
                
                ImagePrefetcher(resources: urls.map({ url in
                    KF.ImageResource(downloadURL: url)
                })) { (_, _, _) in
                    completion(entry)
                }
                .start()
            } else {
                completion(Splatoon3ScheduleInteractiveEntry(date: Date(), schedules: [nil, nil, nil, nil], nextSchedules: [nil, nil, nil, nil]))
            }
        }
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Splatoon3ScheduleInteractiveEntry>) -> ()) {
        fetchSplatoon3Schedules(locale: Locale.localizedLocale) { schedules, error in
            guard error == .NoError else {
                completion(Timeline(entries: [Splatoon3ScheduleInteractiveEntry(date: Date(), schedules: [nil, nil, nil, nil], nextSchedules: [nil, nil, nil, nil])], policy: .after(Date().addingTimeInterval(300))))
                
                return
            }
            
            var entries: [Splatoon3ScheduleInteractiveEntry] = []
            var urls: Set<URL> = []
            let regularFiltered = filterSchedules(schedules: schedules, mode: .regularBattle)
            let anarchySeriesFiltered = filterSchedules(schedules: schedules, mode: .anarchyBattleSeries)
            let anarchyOpenFiltered = filterSchedules(schedules: schedules, mode: .anarchyBattleOpen)
            let xFiltered = filterSchedules(schedules: schedules, mode: .xBattle)
            // HACK: Assume they have the same length.
            if !regularFiltered.isEmpty {
                for i in 0..<MaxScheduleWidgetEntryCount {
                    if regularFiltered.count <= i {
                        break
                    }
                    let entry = Splatoon3ScheduleInteractiveEntry(date: i == 0 ? Date() : regularFiltered.at(index: i)!.startTime, schedules: [regularFiltered.at(index: i)!, anarchySeriesFiltered.at(index: i)!, anarchyOpenFiltered.at(index: i)!, xFiltered.at(index: i)!], nextSchedules: [regularFiltered.at(index: i + 1), anarchySeriesFiltered.at(index: i + 1), anarchyOpenFiltered.at(index: i + 1), xFiltered.at(index: i + 1)])
                    for stage in [regularFiltered.at(index: i)!.stages, anarchySeriesFiltered.at(index: i)!.stages, anarchyOpenFiltered.at(index: i)!.stages, xFiltered.at(index: i)!.stages].flatMap({ $0 }) {
                        urls.insert(stage.thumbnail ?? stage.image)
                    }
                    entries.append(entry)
                }
                
                ImagePrefetcher(resources: urls.map({ url in
                    KF.ImageResource(downloadURL: url)
                })) { (_, _, _) in
                    completion(Timeline(entries: entries, policy: .atEnd))
                }
                .start()
            } else {
                completion(Timeline(entries: [Splatoon3ScheduleInteractiveEntry(date: Date(), schedules: [nil, nil, nil, nil], nextSchedules: [nil, nil, nil, nil])], policy: .after(Date().addingTimeInterval(300))))
            }
        }
    }
}

struct Splatoon3ScheduleInteractiveEntry: TimelineEntry {
    var date: Date

    var schedules: [Splatoon3Schedule?]
    var nextSchedules: [Splatoon3Schedule?]
}

struct Splatoon3ScheduleInteractiveWidgetModelData {
    static var shared: Splatoon3ScheduleInteractiveWidgetModelData = .init()
    
    var _mode: String = Splatoon3ScheduleMode.regularBattle.name
    
    var mode: Splatoon3ScheduleMode {
        Splatoon3ScheduleMode(rawValue: _mode) ?? .regularBattle
    }
}

@available(iOS 17.0, *)
struct Splatoon3ScheduleInteractiveWidgetChangeModeIntent: AppIntent {
    static var title: LocalizedStringResource = "change_mode"
    
    @Parameter(title: "Mode")
    var mode: String
    
    init() {}
    init(mode: String) {
        self.mode = mode
    }
    
    func perform() async throws -> some IntentResult {
        Splatoon3ScheduleInteractiveWidgetModelData.shared._mode = mode
        return .result()
    }
}

@available(iOSApplicationExtension 17.0, *)
struct Splatoon3ScheduleInteractiveWidgetEntryView : View {
    var entry: Splatoon3ScheduleInteractiveProvider.Entry
    
    @ViewBuilder
    var body: some View {
        HStack {
            VStack(spacing: 4) {
                ForEach([Splatoon3ScheduleMode.regularBattle, Splatoon3ScheduleMode.anarchyBattleSeries, Splatoon3ScheduleMode.anarchyBattleOpen, Splatoon3ScheduleMode.xBattle], id: \.name) { mode in
                    Button(intent: Splatoon3ScheduleInteractiveWidgetChangeModeIntent(mode: mode.name)) {
                        Image(mode.image)
                            .resizedToFit()
                            .frame(minWidth: 16, maxWidth: 16, minHeight: 16, maxHeight: .infinity)
                            .padding(2)
                    }
                    .buttonStyle(.borderless)
                    .background {
                        mode.accentColor
                            .opacity(Splatoon3ScheduleInteractiveWidgetModelData.shared.mode == mode ? 0.25 : 0)
                            .cornerRadius(4)
                    }
                }
            }
            MediumScheduleView(mode: Splatoon3ScheduleInteractiveWidgetModelData.shared.mode, schedule: entry.schedules[index], nextSchedule: entry.nextSchedules[index], showsModeImage: false)
                .containerBackground(for: .widget, content: {})
        }
    }
    
    var index: Int {
        switch Splatoon3ScheduleInteractiveWidgetModelData.shared.mode {
        case .regularBattle:
            return 0
        case .anarchyBattleSeries:
            return 1
        case .anarchyBattleOpen:
            return 2
        case .xBattle:
            return 3
        default:
            return 0
        }
    }
}

@available(iOSApplicationExtension 17.0, *)
struct Splatoon3ScheduleInteractiveWidget: Widget {
    let kind = "Splatoon3ScheduleInteractiveWidget"
    
    var supportedFamilies: [WidgetFamily] {
        return [.systemMedium]
    }

    var body: some WidgetConfiguration {
        return StaticConfiguration(kind: kind, provider: Splatoon3ScheduleInteractiveProvider()) { entry in
            Splatoon3ScheduleInteractiveWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("splatoon_3_schedules")
        .description("splatoon_3_schedules_widget_description")
        .supportedFamilies(supportedFamilies)
    }
}

@available(iOSApplicationExtension 17.0, *)
struct Splatoon3ScheduleInteractiveWidgetEntryView_Previews: PreviewProvider {
    static var previews: some View {
        Splatoon3ScheduleInteractiveWidgetEntryView(entry: Splatoon3ScheduleInteractiveEntry(date: Date(), schedules: [PreviewSplatoon3Schedule, PreviewSplatoon3Schedule, PreviewSplatoon3Schedule], nextSchedules: [PreviewSplatoon3Schedule, PreviewSplatoon3Schedule, PreviewSplatoon3Schedule]))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
