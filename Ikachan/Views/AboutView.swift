import SwiftUI
import WidgetKit
import AlertKit
import Kingfisher

struct AboutView: View {
    @AppStorage(UserDefaultsKey.displayOnStartup.rawValue) var displayOnStartup = Game.splatoon3
    @AppStorage(UserDefaultsKey.displayShiftsFirst.rawValue) var displayShiftsFirst = false
    @AppStorage(UserDefaultsKey.splatoon2ScheduleOrder.rawValue) var splatoon2ScheduleOrder = Splatoon2ScheduleMode.allCases
    @AppStorage(UserDefaultsKey.splatoon3ScheduleOrder.rawValue) var splatoon3ScheduleOrder = Splatoon3ScheduleMode.allCases
    @AppStorage(UserDefaultsKey.splatoon3ShiftOrder.rawValue) var splatoon3ShiftOrder = Splatoon3ShiftMode.allCases
    
    var body: some View {
        NavigationView {
            Form {
                Section(LocalizedStringKey("try_our_new_app")) {
                    HStack{
                        Image("conch_bay")
                            .resizedToFit()
                            .frame(width: 60)
                            .cornerRadius(13.2)
                            .overlay(
                                RoundedRectangle(cornerRadius: 13.2)
                                    .stroke(Color(.secondarySystemBackground), lineWidth: 2)
                            )
                            .accessibilityLabel(LocalizedStringKey("conch_bay"))
                        Text(LocalizedStringKey("conch_bay"))
                        
                        Spacer()
                        
                        Button {
                            UIApplication.shared.open(URL(string: "https://testflight.apple.com/join/Er8nuuIp")!)
                        } label: {
                            Text(LocalizedStringKey("join_testing"))
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .padding([.horizontal], 8)
                                .padding([.vertical], -2)
                        }
                        .buttonStyle(.bordered)
                        .buttonBorderShape(.capsule)
                    }
                }
                Section(LocalizedStringKey("preferences")) {
                    Picker("display_on_startup", selection: $displayOnStartup) {
                        ForEach(Game.allCases, id: \.name) { game in
                            Text(LocalizedStringKey(game.name))
                                .tag(game)
                        }
                    }
                    Toggle(LocalizedStringKey("display_shifts_first"), isOn: $displayShiftsFirst)
                    NavigationLink(LocalizedStringKey("display_order")) {
                        Form {
                            Section(LocalizedStringKey("splatoon_3")) {
                                List {
                                    ForEach(splatoon3ScheduleOrder, id: \.self) { mode in
                                        Text(LocalizedStringKey(mode.name))
                                    }
                                    .onMove { from, to in
                                        splatoon3ScheduleOrder.move(fromOffsets: from, toOffset: to)
                                    }
                                }
                            }
                            Section {
                                List {
                                    ForEach(splatoon3ShiftOrder, id: \.self) { mode in
                                        Text(LocalizedStringKey(mode.name))
                                    }
                                    .onMove { from, to in
                                        splatoon3ShiftOrder.move(fromOffsets: from, toOffset: to)
                                    }
                                }
                            }
                            Section(LocalizedStringKey("splatoon_2")) {
                                List {
                                    ForEach(splatoon2ScheduleOrder, id: \.self) { mode in
                                        Text(LocalizedStringKey(mode.name))
                                    }
                                    .onMove { from, to in
                                        splatoon2ScheduleOrder.move(fromOffsets: from, toOffset: to)
                                    }
                                }
                            }
                        }
                        .environment(\.editMode, .constant(.active))
                        .navigationTitle(LocalizedStringKey("display_order"))
                    }
                }
                Section(LocalizedStringKey("settings")) {
                    Link(LocalizedStringKey("language"), destination: URL(string: UIApplication.openSettingsURLString)!)
                    Button(LocalizedStringKey("siri_and_shortcuts")) {
                        let url = URL(string: "shortcuts://")!
                        
                        if UIApplication.shared.canOpenURL(url) {
                            UIApplication.shared.open(url)
                        } else {
                            UIApplication.shared.open(URL(string: "itms-apps://apple.com/app/id915249334")!)
                        }
                    }
                }
                Section(LocalizedStringKey("support")) {
                    Button(LocalizedStringKey("reload_widgets")) {
                        WidgetCenter.shared.reloadAllTimelines()
                        AlertKitAPI.present(title: "widgets_reloaded".localizedString, icon: .done, style: .iOS17AppleMusic, haptic: .success)
                    }
                    Button(LocalizedStringKey("clear_cache")) {
                        KingfisherManager.shared.cache.clearMemoryCache()
                        KingfisherManager.shared.cache.clearDiskCache()
                        AlertKitAPI.present(title: "cache_cleared".localizedString, icon: .done, style: .iOS17AppleMusic, haptic: .success)
                    }
                }
                Section(LocalizedStringKey("about")) {
                    HStack {
                        Text(LocalizedStringKey("version"))
                        
                        Spacer()
                        
                        Text(version)
                    }
                    SafariButton(title: LocalizedStringKey("source_code_repository"), url: URL(string: "https://github.com/zhxie/Ikachan")!)
                    SafariButton(title: LocalizedStringKey("privacy_policy"), url: URL(string: "https://github.com/zhxie/Ikachan/wiki/Privacy-Policy")!)
                    SafariButton(title: LocalizedStringKey("developer_sketch"), url: URL(string: "https://weibo.com/u/2269567390")!)
                    SafariButton(title: LocalizedStringKey("designer_shooky"), url: URL(string: "https://weibo.com/u/6622470330")!)
                }
                Section {
                    SafariButton(title: LocalizedStringKey("splatoon2_ink"), url: URL(string: "https://splatoon2.ink/")!)
                    SafariButton(title: LocalizedStringKey("splatoon3_ink"), url: URL(string: "https://splatoon3.ink/")!)
                    SafariButton(title: LocalizedStringKey("alert_kit"), url: URL(string: "https://github.com/sparrowcode/AlertKit/blob/v5/LICENSE")!)
                    SafariButton(title: LocalizedStringKey("kingfisher"), url: URL(string: "https://github.com/onevcat/Kingfisher/blob/master/LICENSE")!)
                    SafariButton(title: LocalizedStringKey("swifty_json"), url: URL(string: "https://github.com/SwiftyJSON/SwiftyJSON/blob/master/LICENSE")!)
                } header: {
                    Text(LocalizedStringKey("acknowledgements"))
                } footer: {
                    Text(LocalizedStringKey("disclaimer"))
                }
            }
            .navigationTitle(LocalizedStringKey("ikachan"))
        }
    }

    var version: String {
        let dictionary = Bundle.main.infoDictionary!
        let version = dictionary["CFBundleShortVersionString"] as! String
        let build = dictionary["CFBundleVersion"] as! String
        
        return String(format: "%@ (%@)", version, build)
    }
}

#Preview {
    AboutView()
}
