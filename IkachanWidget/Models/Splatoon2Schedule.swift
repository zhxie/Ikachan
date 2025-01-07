import WidgetKit
import Kingfisher

struct Splatoon2ScheduleEntry: TimelineEntry {
    var date: Date
    var configuration: Splatoon2ScheduleIntent

    var schedule: Splatoon2Schedule?
    var nextSchedule: Splatoon2Schedule?
}

struct Splatoon2ScheduleProvider: IntentTimelineProvider {
    func filterSchedules(schedules: [Splatoon2Schedule], mode: INSplatoon2ScheduleMode) -> [Splatoon2Schedule] {
        return schedules.filter { schedule in
            switch mode {
            case .unknown, .regularBattle:
                return schedule._mode == .regularBattle
            case .rankedBattle:
                return schedule._mode == .rankedBattle
            case .leagueBattle:
                return schedule._mode == .leagueBattle
            }
        }.filter { schedule in
            schedule.endTime > Date()
        }
    }
    
    @available(iOSApplicationExtension 17.0, watchOSApplicationExtension 9.0, *)
    func recommendations() -> [IntentRecommendation<Splatoon2ScheduleIntent>] {
        return [INSplatoon2ScheduleMode.regularBattle, INSplatoon2ScheduleMode.rankedBattle, INSplatoon2ScheduleMode.leagueBattle].map { mode in
            let intent = Splatoon2ScheduleIntent()
            intent.mode = mode
            return IntentRecommendation(intent: intent, description: "splatoon_2_schedule_widget_description")
        }
    }
    
    func placeholder(in context: Context) -> Splatoon2ScheduleEntry {
        Splatoon2ScheduleEntry(date: Date(), configuration: Splatoon2ScheduleIntent(), schedule: PreviewSplatoon2Schedule, nextSchedule: PreviewSplatoon2Schedule)
    }

    func getSnapshot(for configuration: Splatoon2ScheduleIntent, in context: Context, completion: @escaping (Splatoon2ScheduleEntry) -> ()) {
        fetchSplatoon2Schedules(locale: Locale.localizedLocale) { schedules, error in
            guard error == .NoError else {
                completion(Splatoon2ScheduleEntry(date: Date(), configuration: configuration, schedule: nil))
                
                return
            }
            
            let filtered = filterSchedules(schedules: schedules, mode: configuration.mode)
            if !filtered.isEmpty {
                let entry = Splatoon2ScheduleEntry(date: Date(), configuration: configuration, schedule: filtered.first!, nextSchedule: filtered.at(index: 1))
                var urls: Set<URL> = []
                for stage in filtered.first!.stages {
                    urls.insert(stage.thumbnail ?? stage.image)
                }
                
                ImagePrefetcher(resources: urls.map({ url in
                    KF.ImageResource(downloadURL: url)
                })) { (_, _, _) in
                    completion(entry)
                }
                .start()
            } else {
                completion(Splatoon2ScheduleEntry(date: Date(), configuration: configuration, schedule: nil))
            }
        }
    }

    func getTimeline(for configuration: Splatoon2ScheduleIntent, in context: Context, completion: @escaping (Timeline<Splatoon2ScheduleEntry>) -> ()) {
        fetchSplatoon2Schedules(locale: Locale.localizedLocale) { schedules, error in
            guard error == .NoError else {
                completion(Timeline(entries: [Splatoon2ScheduleEntry(date: Date(), configuration: configuration, schedule: nil)], policy: .after(Date().addingTimeInterval(300))))
                
                return
            }
            
            var entries: [Splatoon2ScheduleEntry] = []
            var urls: Set<URL> = []
            let filtered = filterSchedules(schedules: schedules, mode: configuration.mode)
            if !filtered.isEmpty {
                for i in 0..<MaxScheduleWidgetEntryCount {
                    if filtered.count <= i {
                        break
                    }
                    let entry = Splatoon2ScheduleEntry(date: i == 0 ? Date() : filtered.at(index: i)!.startTime, configuration: configuration, schedule: filtered.at(index: i)!, nextSchedule: filtered.at(index: i + 1))
                    for stage in filtered.at(index: i)!.stages {
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
                completion(Timeline(entries: [Splatoon2ScheduleEntry(date: Date(), configuration: configuration, schedule: nil)], policy: .after(Date().addingTimeInterval(300))))
            }
        }
    }
}

struct Splatoon2ScheduleProgressProvider: IntentTimelineProvider {
    func filterSchedules(schedules: [Splatoon2Schedule], mode: INSplatoon2ScheduleMode) -> [Splatoon2Schedule] {
        return schedules.filter { schedule in
            switch mode {
            case .unknown, .regularBattle:
                return schedule._mode == .regularBattle
            case .rankedBattle:
                return schedule._mode == .rankedBattle
            case .leagueBattle:
                return schedule._mode == .leagueBattle
            }
        }.filter { schedule in
            schedule.endTime > Date()
        }
    }
    
    @available(iOSApplicationExtension 17.0, watchOSApplicationExtension 9.0, *)
    func recommendations() -> [IntentRecommendation<Splatoon2ScheduleIntent>] {
        return [INSplatoon2ScheduleMode.regularBattle, INSplatoon2ScheduleMode.rankedBattle, INSplatoon2ScheduleMode.leagueBattle].map { mode in
            let intent = Splatoon2ScheduleIntent()
            intent.mode = mode
            return IntentRecommendation(intent: intent, description: "splatoon_2_schedule_widget_description")
        }
    }
    
    func placeholder(in context: Context) -> Splatoon2ScheduleEntry {
        Splatoon2ScheduleEntry(date: Date(), configuration: Splatoon2ScheduleIntent(), schedule: PreviewSplatoon2Schedule)
    }

    func getSnapshot(for configuration: Splatoon2ScheduleIntent, in context: Context, completion: @escaping (Splatoon2ScheduleEntry) -> ()) {
        fetchSplatoon2Schedules(locale: Locale.localizedLocale) { schedules, error in
            guard error == .NoError else {
                completion(Splatoon2ScheduleEntry(date: Date(), configuration: configuration, schedule: nil))
                
                return
            }
            
            let filtered = filterSchedules(schedules: schedules, mode: configuration.mode)
            if !filtered.isEmpty {
                completion(Splatoon2ScheduleEntry(date: Date(), configuration: configuration, schedule: filtered.first!))
            } else {
                completion(Splatoon2ScheduleEntry(date: Date(), configuration: configuration, schedule: nil))
            }
        }
    }

    func getTimeline(for configuration: Splatoon2ScheduleIntent, in context: Context, completion: @escaping (Timeline<Splatoon2ScheduleEntry>) -> ()) {
        fetchSplatoon2Schedules(locale: Locale.localizedLocale) { schedules, error in
            guard error == .NoError else {
                completion(Timeline(entries: [Splatoon2ScheduleEntry(date: Date(), configuration: configuration, schedule: nil)], policy: .after(Date().addingTimeInterval(300))))
                
                return
            }
            
            var entries: [Splatoon2ScheduleEntry] = []
            let filtered = filterSchedules(schedules: schedules, mode: configuration.mode)
            if !filtered.isEmpty {
                var current = Date().floorToMin()
                for schedule in filtered {
                    while current < schedule.endTime && entries.count < MaxDynamicWidgetEntryCount {
                        let entry = Splatoon2ScheduleEntry(date: current, configuration: configuration, schedule: schedule)
                        entries.append(entry)
                        
                        current = current.addingTimeInterval(60)
                    }
                }
                
                completion(Timeline(entries: entries, policy: .atEnd))
            } else {
                completion(Timeline(entries: [Splatoon2ScheduleEntry(date: Date(), configuration: configuration, schedule: nil)], policy: .after(Date().addingTimeInterval(300))))
            }
        }
    }
}
