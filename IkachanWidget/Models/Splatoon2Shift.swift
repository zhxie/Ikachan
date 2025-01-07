import WidgetKit
import Kingfisher

struct Splatoon2ShiftEntry: TimelineEntry {
    var date: Date
    var configuration: Splatoon2ShiftIntent

    var shift: Splatoon2Shift?
    var nextShift: Splatoon2Shift?
}

struct Splatoon2ShiftProvider: IntentTimelineProvider {
    func filterShifts(shifts: [Splatoon2Shift]) -> [Splatoon2Shift] {
        return shifts.filter { schedule in
            schedule.endTime > Date()
        }
    }
    
    @available(iOSApplicationExtension 17.0, watchOSApplicationExtension 9.0, *)
    func recommendations() -> [IntentRecommendation<Splatoon2ShiftIntent>] {
        return [IntentRecommendation(intent: Splatoon2ShiftIntent(), description: "splatoon_2_shift_widget_description")]
    }
    
    func placeholder(in context: Context) -> Splatoon2ShiftEntry {
        Splatoon2ShiftEntry(date: Date(), configuration: Splatoon2ShiftIntent(), shift: PreviewSplatoon2Shift, nextShift: PreviewSplatoon2Shift)
    }

    func getSnapshot(for configuration: Splatoon2ShiftIntent, in context: Context, completion: @escaping (Splatoon2ShiftEntry) -> ()) {
        fetchSplatoon2Shifts(locale: Locale.localizedLocale) { shifts, error in
            guard error == .NoError else {
                completion(Splatoon2ShiftEntry(date: Date(), configuration: configuration, shift: nil))
                
                return
            }
            
            let filtered = filterShifts(shifts: shifts)
            if !filtered.isEmpty {
                var entry = Splatoon2ShiftEntry(date: Date(), configuration: configuration, shift: filtered.first!)
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
                completion(Splatoon2ShiftEntry(date: Date(), configuration: configuration, shift: nil))
            }
        }
    }

    func getTimeline(for configuration: Splatoon2ShiftIntent, in context: Context, completion: @escaping (Timeline<Splatoon2ShiftEntry>) -> ()) {
        fetchSplatoon2Shifts(locale: Locale.localizedLocale) { shifts, error in
            guard error == .NoError else {
                completion(Timeline(entries: [Splatoon2ShiftEntry(date: Date(), configuration: configuration, shift: nil)], policy: .after(Date().addingTimeInterval(300))))
                
                return
            }
            
            var entries: [Splatoon2ShiftEntry] = []
            var urls: Set<URL> = []
            let filtered = filterShifts(shifts: shifts)
            if !filtered.isEmpty {
                for i in 0..<MaxShiftWidgetEntryCount {
                    if filtered.count <= i {
                        break
                    }
                    var entry = Splatoon2ShiftEntry(date: i == 0 ? Date() : filtered.at(index: i)!.startTime, configuration: configuration, shift: filtered.at(index: i)!)
                    if filtered.at(index: i)!.stage != nil {
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
                completion(Timeline(entries: [Splatoon2ShiftEntry(date: Date(), configuration: configuration, shift: nil)], policy: .after(Date().addingTimeInterval(300))))
            }
        }
    }
}

struct Splatoon2ShiftProgressProvider: IntentTimelineProvider {
    func filterShifts(shifts: [Splatoon2Shift]) -> [Splatoon2Shift] {
        return shifts.filter { shift in
            shift.endTime > Date()
        }
    }
    
    @available(iOSApplicationExtension 17.0, watchOSApplicationExtension 9.0, *)
    func recommendations() -> [IntentRecommendation<Splatoon2ShiftIntent>] {
        return [IntentRecommendation(intent: Splatoon2ShiftIntent(), description: "splatoon_2_shift_widget_description")]
    }
    
    func placeholder(in context: Context) -> Splatoon2ShiftEntry {
        Splatoon2ShiftEntry(date: Date(), configuration: Splatoon2ShiftIntent(), shift: PreviewSplatoon2Shift)
    }

    func getSnapshot(for configuration: Splatoon2ShiftIntent, in context: Context, completion: @escaping (Splatoon2ShiftEntry) -> ()) {
        fetchSplatoon2Shifts(locale: Locale.localizedLocale) { shifts, error in
            guard error == .NoError else {
                completion(Splatoon2ShiftEntry(date: Date(), configuration: configuration, shift: nil))
                
                return
            }
            
            let filtered = filterShifts(shifts: shifts)
            if !filtered.isEmpty {
                completion(Splatoon2ShiftEntry(date: Date(), configuration: configuration, shift: filtered.first!))
            } else {
                completion(Splatoon2ShiftEntry(date: Date(), configuration: configuration, shift: nil))
            }
        }
    }

    func getTimeline(for configuration: Splatoon2ShiftIntent, in context: Context, completion: @escaping (Timeline<Splatoon2ShiftEntry>) -> ()) {
        fetchSplatoon2Shifts(locale: Locale.localizedLocale) { shifts, error in
            guard error == .NoError else {
                completion(Timeline(entries: [Splatoon2ShiftEntry(date: Date(), configuration: configuration, shift: nil)], policy: .after(Date().addingTimeInterval(300))))
                
                return
            }
            
            var entries: [Splatoon2ShiftEntry] = []
            let filtered = filterShifts(shifts: shifts)
            if !filtered.isEmpty {
                var current = Date().floorToMin()
                for shift in filtered {
                    while current < shift.endTime && entries.count < MaxDynamicWidgetEntryCount {
                        let entry = Splatoon2ShiftEntry(date: current, configuration: configuration, shift: shift)
                        entries.append(entry)
                        
                        current = current.addingTimeInterval(60)
                    }
                }
                
                completion(Timeline(entries: entries, policy: .atEnd))
            } else {
                completion(Timeline(entries: [Splatoon2ShiftEntry(date: Date(), configuration: configuration, shift: nil)], policy: .after(Date().addingTimeInterval(300))))
            }
        }
    }
}
