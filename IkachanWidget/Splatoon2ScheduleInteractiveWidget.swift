import WidgetKit
import SwiftUI
import Intents
import Kingfisher
import AppIntents

struct Splatoon2ScheduleInteractiveProvider: TimelineProvider {
    func filterSchedules(schedules: [Splatoon2Schedule], mode: Splatoon2ScheduleMode) -> [Splatoon2Schedule] {
        return schedules.filter { schedule in
            schedule._mode == mode
        }.filter { schedule in
            schedule.endTime > Date()
        }
    }
    
    func placeholder(in context: Context) -> Splatoon2ScheduleInteractiveEntry {
        Splatoon2ScheduleInteractiveEntry(date: Date(), schedules: [PreviewSplatoon2Schedule, PreviewSplatoon2Schedule, PreviewSplatoon2Schedule], nextSchedules: [PreviewSplatoon2Schedule, PreviewSplatoon2Schedule, PreviewSplatoon2Schedule])
    }
    
    func getSnapshot(in context: Context, completion: @escaping (Splatoon2ScheduleInteractiveEntry) -> ()) {
        fetchSplatoon2Schedules(locale: Locale.localizedLocale) { schedules, error in
            guard error == .NoError else {
                completion(Splatoon2ScheduleInteractiveEntry(date: Date(), schedules: [nil, nil, nil], nextSchedules: [nil, nil, nil]))
                
                return
            }
            
            let regularFiltered = filterSchedules(schedules: schedules, mode: .regularBattle)
            let rankedFiltered = filterSchedules(schedules: schedules, mode: .rankedBattle)
            let leagueFiltered = filterSchedules(schedules: schedules, mode: .leagueBattle)
            // HACK: Assume they have the same length.
            if !regularFiltered.isEmpty {
                let entry = Splatoon2ScheduleInteractiveEntry(date: Date(), schedules: [regularFiltered.first!, rankedFiltered.first!, leagueFiltered.first!], nextSchedules: [regularFiltered.at(index: 1), rankedFiltered.at(index: 1), leagueFiltered.at(index: 1)])
                var urls: Set<URL> = []
                for stage in [regularFiltered.first!.stages, rankedFiltered.first!.stages, leagueFiltered.first!.stages].flatMap({ $0 }) {
                    urls.insert(stage.thumbnail ?? stage.image)
                }
                
                ImagePrefetcher(resources: urls.map({ url in
                    KF.ImageResource(downloadURL: url)
                })) { (_, _, _) in
                    completion(entry)
                }
                .start()
            } else {
                completion(Splatoon2ScheduleInteractiveEntry(date: Date(), schedules: [nil, nil, nil], nextSchedules: [nil, nil, nil]))
            }
        }
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Splatoon2ScheduleInteractiveEntry>) -> ()) {
        fetchSplatoon2Schedules(locale: Locale.localizedLocale) { schedules, error in
            guard error == .NoError else {
                completion(Timeline(entries: [Splatoon2ScheduleInteractiveEntry(date: Date(), schedules: [nil, nil, nil], nextSchedules: [nil, nil, nil])], policy: .after(Date().addingTimeInterval(300))))
                
                return
            }
            
            var entries: [Splatoon2ScheduleInteractiveEntry] = []
            var urls: Set<URL> = []
            let regularFiltered = filterSchedules(schedules: schedules, mode: .regularBattle)
            let rankedFiltered = filterSchedules(schedules: schedules, mode: .rankedBattle)
            let leagueFiltered = filterSchedules(schedules: schedules, mode: .leagueBattle)
            // HACK: Assume they have the same length.
            if !regularFiltered.isEmpty {
                for i in 0..<MaxScheduleWidgetEntryCount {
                    if regularFiltered.count <= i {
                        break
                    }
                    let entry = Splatoon2ScheduleInteractiveEntry(date: i == 0 ? Date() : regularFiltered.at(index: i)!.startTime, schedules: [regularFiltered.at(index: i)!, rankedFiltered.at(index: i)!, leagueFiltered.at(index: i)!], nextSchedules: [regularFiltered.at(index: i + 1), rankedFiltered.at(index: i + 1), leagueFiltered.at(index: i + 1)])
                    for stage in [regularFiltered.at(index: i)!.stages, rankedFiltered.at(index: i)!.stages, leagueFiltered.at(index: i)!.stages].flatMap({ $0 }) {
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
                completion(Timeline(entries: [Splatoon2ScheduleInteractiveEntry(date: Date(), schedules: [nil, nil, nil], nextSchedules: [nil, nil, nil])], policy: .after(Date().addingTimeInterval(300))))
            }
        }
    }
}

struct Splatoon2ScheduleInteractiveEntry: TimelineEntry {
    var date: Date

    var schedules: [Splatoon2Schedule?]
    var nextSchedules: [Splatoon2Schedule?]
}

struct Splatoon2ScheduleInteractiveWidgetModelData {
    static var shared: Splatoon2ScheduleInteractiveWidgetModelData = .init()
    
    var _mode: String = Splatoon2ScheduleMode.regularBattle.name
    
    var mode: Splatoon2ScheduleMode {
        Splatoon2ScheduleMode(rawValue: _mode) ?? .regularBattle
    }
}

@available(iOS 17.0, *)
struct Splatoon2ScheduleInteractiveWidgetChangeModeIntent: AppIntent {
    static var title: LocalizedStringResource = "change_mode"
    
    @Parameter(title: "Mode")
    var mode: String
    
    init() {}
    init(mode: String) {
        self.mode = mode
    }
    
    func perform() async throws -> some IntentResult {
        Splatoon2ScheduleInteractiveWidgetModelData.shared._mode = mode
        return .result()
    }
}

@available(iOSApplicationExtension 17.0, *)
struct Splatoon2ScheduleInteractiveWidgetEntryView : View {
    var entry: Splatoon2ScheduleInteractiveProvider.Entry
    
    @ViewBuilder
    var body: some View {
        HStack {
            VStack(spacing: 4) {
                ForEach(Splatoon2ScheduleMode.allCases, id: \.name) { mode in
                    Button(intent: Splatoon2ScheduleInteractiveWidgetChangeModeIntent(mode: mode.name)) {
                        Image(mode.image)
                            .resizedToFit()
                            .frame(minWidth: 16, maxWidth: 16, minHeight: 16, maxHeight: .infinity)
                            .padding(2)
                    }
                    .buttonStyle(.borderless)
                    .background {
                        mode.accentColor
                            .opacity(Splatoon2ScheduleInteractiveWidgetModelData.shared.mode == mode ? 0.25 : 0)
                            .cornerRadius(4)
                    }
                }
            }
            MediumScheduleView(schedule: entry.schedules[index], nextSchedule: entry.nextSchedules[index], showsModeImage: false)
                .containerBackground(for: .widget, content: {})
        }
    }
    
    var index: Int {
        switch Splatoon2ScheduleInteractiveWidgetModelData.shared.mode {
        case .regularBattle:
            return 0
        case .rankedBattle:
            return 1
        case .leagueBattle:
            return 2
        }
    }
}

@available(iOSApplicationExtension 17.0, *)
struct Splatoon2ScheduleInteractiveWidget: Widget {
    let kind = "Splatoon2ScheduleInteractiveWidget"
    
    var supportedFamilies: [WidgetFamily] {
        return [.systemMedium]
    }

    var body: some WidgetConfiguration {
        return StaticConfiguration(kind: kind, provider: Splatoon2ScheduleInteractiveProvider()) { entry in
            Splatoon2ScheduleInteractiveWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("splatoon_2_schedules")
        .description("splatoon_2_schedules_widget_description")
        .supportedFamilies(supportedFamilies)
    }
}

@available(iOSApplicationExtension 17.0, *)
struct Splatoon2ScheduleInteractiveWidgetEntryView_Previews: PreviewProvider {
    static var previews: some View {
        Splatoon2ScheduleInteractiveWidgetEntryView(entry: Splatoon2ScheduleInteractiveEntry(date: Date(), schedules: [PreviewSplatoon2Schedule, PreviewSplatoon2Schedule, PreviewSplatoon2Schedule], nextSchedules: [PreviewSplatoon2Schedule, PreviewSplatoon2Schedule, PreviewSplatoon2Schedule]))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
