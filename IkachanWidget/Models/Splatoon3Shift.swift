import WidgetKit
import Kingfisher

struct Splatoon3ShiftEntry: TimelineEntry {
    var date: Date
    var configuration: Splatoon3ShiftIntent

    var shift: Splatoon3Shift?
    var nextShift: Splatoon3Shift?
}

struct Splatoon3ShiftProvider: IntentTimelineProvider {
    func filterShifts(shifts: [Splatoon3Shift], mode: INSplatoon3ShiftMode) -> [Splatoon3Shift] {
        return shifts.filter { shift in
            switch mode {
            case .unknown, .salmonRunAndBigRun:
                return shift._mode == .salmonRun || shift._mode == .bigRun
            case .eggstraWork:
                return shift._mode == .eggstraWork
            @unknown default:
                // HACK: We have dropped value 2 for Big Run in the previous change.
                return shift._mode == .salmonRun || shift._mode == .bigRun
            }
        }.filter { schedule in
            schedule.endTime > Date()
        }.sorted { a, b in
            a.startTime < b.startTime
        }
    }
    
    @available(iOSApplicationExtension 17.0, watchOSApplicationExtension 9.0, *)
    func recommendations() -> [IntentRecommendation<Splatoon3ShiftIntent>] {
        return [INSplatoon3ShiftMode.salmonRunAndBigRun, INSplatoon3ShiftMode.eggstraWork].map { mode in
            let intent = Splatoon3ShiftIntent()
            intent.mode = mode
            return IntentRecommendation(intent: intent, description: String(format: String(localized: "widget_recommendation_description"), Game.splatoon3.name.localizedString, Splatoon3ShiftMode(from: mode).name.localizedString))
        }
    }
    
    func placeholder(in context: Context) -> Splatoon3ShiftEntry {
        Splatoon3ShiftEntry(date: Date(), configuration: Splatoon3ShiftIntent(), shift: PreviewSplatoon3Shift, nextShift: PreviewSplatoon3Shift)
    }

    func getSnapshot(for configuration: Splatoon3ShiftIntent, in context: Context, completion: @escaping (Splatoon3ShiftEntry) -> ()) {
        fetchSplatoon3Shifts(locale: Locale.localizedLocale) { shifts, error in
            guard error == .NoError else {
                completion(Splatoon3ShiftEntry(date: Date(), configuration: configuration, shift: nil))
                
                return
            }
            
            let filtered = filterShifts(shifts: shifts, mode: configuration.mode)
            if !filtered.isEmpty {
                var entry = Splatoon3ShiftEntry(date: Date(), configuration: configuration, shift: filtered.first!)
                var urls: Set<URL> = []
                if let stage = filtered.first!.stage {
                    urls.insert(stage.thumbnail ?? stage.image)
                    for weapon in filtered.first!.weapons! {
                        urls.insert(weapon.thumbnail ?? weapon.image)
                    }
                }
                if filtered.count > 1 {
                    entry.nextShift = filtered.at(index: 1)!
                    if let weapons = filtered.at(index: 1)!.weapons {
                        for weapon in weapons {
                            urls.insert(weapon.thumbnail ?? weapon.image)
                        }
                    }
                }
                
                ImagePrefetcher(resources: urls.map({ url in
                    KF.ImageResource(downloadURL: url)
                })) { (_, _, _) in
                    completion(entry)
                }
                .start()
            } else {
                completion(Splatoon3ShiftEntry(date: Date(), configuration: configuration, shift: nil))
            }
        }
    }

    func getTimeline(for configuration: Splatoon3ShiftIntent, in context: Context, completion: @escaping (Timeline<Splatoon3ShiftEntry>) -> ()) {
        fetchSplatoon3Shifts(locale: Locale.localizedLocale) { shifts, error in
            guard error == .NoError else {
                completion(Timeline(entries: [Splatoon3ShiftEntry(date: Date(), configuration: configuration, shift: nil)], policy: .after(Date().addingTimeInterval(300))))
                
                return
            }
            
            var entries: [Splatoon3ShiftEntry] = []
            var urls: Set<URL> = []
            let filtered = filterShifts(shifts: shifts, mode: configuration.mode)
            if !filtered.isEmpty {
                for i in 0..<MaxShiftWidgetEntryCount {
                    if filtered.count <= i {
                        break
                    }
                    var entry = Splatoon3ShiftEntry(date: i == 0 ? Date() : filtered.at(index: i)!.startTime, configuration: configuration, shift: filtered.at(index: i)!)
                    if let stage = filtered.at(index: i)!.stage {
                        urls.insert(stage.thumbnail ?? stage.image)
                        for weapon in filtered.at(index: i)!.weapons! {
                            urls.insert(weapon.thumbnail ?? weapon.image)
                        }
                    }
                    if (filtered.count > i + 1) {
                        entry.nextShift = filtered.at(index: i + 1)!
                        if let weapons = filtered.at(index: i + 1)!.weapons {
                            for weapon in weapons {
                                urls.insert(weapon.thumbnail ?? weapon.image)
                            }
                        }
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
                completion(Timeline(entries: [Splatoon3ShiftEntry(date: Date(), configuration: configuration, shift: nil)], policy: .after(Date().addingTimeInterval(300))))
            }
        }
    }
}

struct Splatoon3ShiftProgressProvider: IntentTimelineProvider {
    func filterShifts(shifts: [Splatoon3Shift], mode: INSplatoon3ShiftMode) -> [Splatoon3Shift] {
        return shifts.filter { shift in
            switch mode {
            case .unknown, .salmonRunAndBigRun:
                return shift._mode == .salmonRun || shift._mode == .bigRun
            case .eggstraWork:
                return shift._mode == .eggstraWork
            }
        }.filter { shift in
            shift.endTime > Date()
        }.sorted { a, b in
            a.startTime < b.startTime
        }
    }
    
    @available(iOSApplicationExtension 17.0, watchOSApplicationExtension 9.0, *)
    func recommendations() -> [IntentRecommendation<Splatoon3ShiftIntent>] {
        return [INSplatoon3ShiftMode.salmonRunAndBigRun, INSplatoon3ShiftMode.eggstraWork].map { mode in
            let intent = Splatoon3ShiftIntent()
            intent.mode = mode
            return IntentRecommendation(intent: intent, description: String(format: String(localized: "widget_recommendation_description"), Game.splatoon3.name.localizedString, Splatoon3ShiftMode(from: mode).name.localizedString))
        }
    }
    
    func placeholder(in context: Context) -> Splatoon3ShiftEntry {
        Splatoon3ShiftEntry(date: Date(), configuration: Splatoon3ShiftIntent(), shift: PreviewSplatoon3Shift)
    }

    func getSnapshot(for configuration: Splatoon3ShiftIntent, in context: Context, completion: @escaping (Splatoon3ShiftEntry) -> ()) {
        fetchSplatoon3Shifts(locale: Locale.localizedLocale) { shifts, error in
            guard error == .NoError else {
                completion(Splatoon3ShiftEntry(date: Date(), configuration: configuration, shift: nil))
                
                return
            }
            
            let filtered = filterShifts(shifts: shifts, mode: configuration.mode)
            if !filtered.isEmpty {
                completion(Splatoon3ShiftEntry(date: Date(), configuration: configuration, shift: filtered.first!))
            } else {
                completion(Splatoon3ShiftEntry(date: Date(), configuration: configuration, shift: nil))
            }
        }
    }

    func getTimeline(for configuration: Splatoon3ShiftIntent, in context: Context, completion: @escaping (Timeline<Splatoon3ShiftEntry>) -> ()) {
        fetchSplatoon3Shifts(locale: Locale.localizedLocale) { shifts, error in
            guard error == .NoError else {
                completion(Timeline(entries: [Splatoon3ShiftEntry(date: Date(), configuration: configuration, shift: nil)], policy: .after(Date().addingTimeInterval(300))))
                
                return
            }
            
            var entries: [Splatoon3ShiftEntry] = []
            let filtered = filterShifts(shifts: shifts, mode: configuration.mode)
            if !filtered.isEmpty {
                var current = Date().floorToMin()
                for shift in filtered {
                    while current < shift.endTime && entries.count < MaxDynamicWidgetEntryCount {
                        let entry = Splatoon3ShiftEntry(date: current, configuration: configuration, shift: shift)
                        entries.append(entry)
                        
                        current = current.addingTimeInterval(60)
                    }
                }
                
                completion(Timeline(entries: entries, policy: .atEnd))
            } else {
                completion(Timeline(entries: [Splatoon3ShiftEntry(date: Date(), configuration: configuration, shift: nil)], policy: .after(Date().addingTimeInterval(300))))
            }
        }
    }
}
