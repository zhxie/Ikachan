import WidgetKit
import Kingfisher

struct Splatoon3ScheduleEntry: TimelineEntry {
    var date: Date
    var configuration: Splatoon3ScheduleIntent

    var schedule: Splatoon3Schedule?
    var nextSchedule: Splatoon3Schedule?
}

struct Splatoon3ScheduleProvider: IntentTimelineProvider {
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
    
    @available(iOSApplicationExtension 17.0, watchOSApplicationExtension 9.0, *)
    func recommendations() -> [IntentRecommendation<Splatoon3ScheduleIntent>] {
        return [INSplatoon3ScheduleMode.regularBattle, INSplatoon3ScheduleMode.anarchyBattleSeries, INSplatoon3ScheduleMode.anarchyBattleOpen, INSplatoon3ScheduleMode.xBattle, INSplatoon3ScheduleMode.challenges, INSplatoon3ScheduleMode.splatfestBattleOpen, INSplatoon3ScheduleMode.splatfestBattlePro, INSplatoon3ScheduleMode.tricolorBattle].map { mode in
            let intent = Splatoon3ScheduleIntent()
            intent.mode = mode
            return IntentRecommendation(intent: intent, description: "splatoon_3_schedule_widget_description")
        }
    }
    
    func placeholder(in context: Context) -> Splatoon3ScheduleEntry {
        Splatoon3ScheduleEntry(date: Date(), configuration: Splatoon3ScheduleIntent(), schedule: PreviewSplatoon3Schedule, nextSchedule: PreviewSplatoon3Schedule)
    }

    func getSnapshot(for configuration: Splatoon3ScheduleIntent, in context: Context, completion: @escaping (Splatoon3ScheduleEntry) -> ()) {
        fetchSplatoon3Schedules(locale: Locale.localizedLocale) { schedules, error in
            guard error == .NoError else {
                completion(Splatoon3ScheduleEntry(date: Date(), configuration: configuration, schedule: nil))
                
                return
            }
            
            let filtered = filterSchedules(schedules: schedules, mode: configuration.mode)
            if !filtered.isEmpty {
                let entry = Splatoon3ScheduleEntry(date: Date(), configuration: configuration, schedule: filtered.first!, nextSchedule: filtered.suffix(from: 1).first(where: { schedule in
                    schedule.challenge == nil || schedule.challenge != filtered.first!.challenge
                }))
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
                completion(Splatoon3ScheduleEntry(date: Date(), configuration: configuration, schedule: nil))
            }
        }
    }

    func getTimeline(for configuration: Splatoon3ScheduleIntent, in context: Context, completion: @escaping (Timeline<Splatoon3ScheduleEntry>) -> ()) {
        fetchSplatoon3Schedules(locale: Locale.localizedLocale) { schedules, error in
            guard error == .NoError else {
                completion(Timeline(entries: [Splatoon3ScheduleEntry(date: Date(), configuration: configuration, schedule: nil)], policy: .after(Date().addingTimeInterval(300))))
                
                return
            }
            
            var entries: [Splatoon3ScheduleEntry] = []
            var urls: Set<URL> = []
            let filtered = filterSchedules(schedules: schedules, mode: configuration.mode)
            if !filtered.isEmpty {
                for i in 0..<MaxScheduleWidgetEntryCount {
                    if filtered.count <= i {
                        break
                    }
                    let entry = Splatoon3ScheduleEntry(date: i == 0 ? Date() : filtered.at(index: i)!.startTime, configuration: configuration, schedule: filtered.at(index: i)!, nextSchedule: filtered.suffix(from: i + 1).first(where: { schedule in
                        schedule.challenge == nil || schedule.challenge != filtered.at(index: i)!.challenge
                    }))
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
                completion(Timeline(entries: [Splatoon3ScheduleEntry(date: Date(), configuration: configuration, schedule: nil)], policy: .after(Date().addingTimeInterval(300))))
            }
        }
    }
}

struct Splatoon3ScheduleProgressProvider: IntentTimelineProvider {
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
    
    @available(iOSApplicationExtension 17.0, watchOSApplicationExtension 9.0, *)
    func recommendations() -> [IntentRecommendation<Splatoon3ScheduleIntent>] {
        return [INSplatoon3ScheduleMode.regularBattle, INSplatoon3ScheduleMode.anarchyBattleSeries, INSplatoon3ScheduleMode.anarchyBattleOpen, INSplatoon3ScheduleMode.xBattle, INSplatoon3ScheduleMode.challenges, INSplatoon3ScheduleMode.splatfestBattleOpen, INSplatoon3ScheduleMode.splatfestBattlePro, INSplatoon3ScheduleMode.tricolorBattle].map { mode in
            let intent = Splatoon3ScheduleIntent()
            intent.mode = mode
            return IntentRecommendation(intent: intent, description: "splatoon_3_schedule_widget_description")
        }
    }
    
    func placeholder(in context: Context) -> Splatoon3ScheduleEntry {
        Splatoon3ScheduleEntry(date: Date(), configuration: Splatoon3ScheduleIntent(), schedule: PreviewSplatoon3Schedule)
    }

    func getSnapshot(for configuration: Splatoon3ScheduleIntent, in context: Context, completion: @escaping (Splatoon3ScheduleEntry) -> ()) {
        fetchSplatoon3Schedules(locale: Locale.localizedLocale) { schedules, error in
            guard error == .NoError else {
                completion(Splatoon3ScheduleEntry(date: Date(), configuration: configuration, schedule: nil))
                
                return
            }
            
            let filtered = filterSchedules(schedules: schedules, mode: configuration.mode)
            if !filtered.isEmpty {
                completion(Splatoon3ScheduleEntry(date: Date(), configuration: configuration, schedule: filtered.first!))
            } else {
                completion(Splatoon3ScheduleEntry(date: Date(), configuration: configuration, schedule: nil))
            }
        }
    }

    func getTimeline(for configuration: Splatoon3ScheduleIntent, in context: Context, completion: @escaping (Timeline<Splatoon3ScheduleEntry>) -> ()) {
        fetchSplatoon3Schedules(locale: Locale.localizedLocale) { schedules, error in
            guard error == .NoError else {
                completion(Timeline(entries: [Splatoon3ScheduleEntry(date: Date(), configuration: configuration, schedule: nil)], policy: .after(Date().addingTimeInterval(300))))
                
                return
            }
            
            var entries: [Splatoon3ScheduleEntry] = []
            let filtered = filterSchedules(schedules: schedules, mode: configuration.mode)
            if !filtered.isEmpty {
                var current = Date().floorToMin()
                for schedule in filtered {
                    while current < schedule.endTime && entries.count < MaxDynamicWidgetEntryCount {
                        let entry = Splatoon3ScheduleEntry(date: current, configuration: configuration, schedule: schedule)
                        entries.append(entry)
                        
                        current = current.addingTimeInterval(60)
                    }
                }
                
                completion(Timeline(entries: entries, policy: .atEnd))
            } else {
                completion(Timeline(entries: [Splatoon3ScheduleEntry(date: Date(), configuration: configuration, schedule: nil)], policy: .after(Date().addingTimeInterval(300))))
            }
        }
    }
}
