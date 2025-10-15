import SwiftUI
import WidgetKit
import AlertKit
import Kingfisher

struct AboutView: View {
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var settings = Settings.shared
    
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
                                .textCase(.uppercase)
                                .padding([.horizontal], 8)
                                .padding([.vertical], -2)
                        }
                        .buttonStyle(.bordered)
                        .buttonBorderShape(.capsule)
                    }
                }
                Section(LocalizedStringKey("preferences")) {
                    Picker("display_on_startup", selection: $settings.displayOnStartup) {
                        ForEach(Game.allCases, id: \.name) { game in
                            Text(LocalizedStringKey(game.name))
                                .tag(game)
                        }
                    }
                    Toggle(LocalizedStringKey("display_shifts_first"), isOn: $settings.displayShiftsFirst)
                    NavigationLink(LocalizedStringKey("display_order")) {
                        Form {
                            Section(LocalizedStringKey("splatoon_3")) {
                                List {
                                    ForEach(settings.splatoon3ScheduleOrder, id: \.self) { mode in
                                        Text(LocalizedStringKey(mode.name))
                                    }
                                    .onMove { from, to in
                                        settings.splatoon3ScheduleOrder.move(fromOffsets: from, toOffset: to)
                                    }
                                }
                            }
                            Section {
                                List {
                                    ForEach(settings.splatoon3ShiftOrder, id: \.self) { mode in
                                        Text(LocalizedStringKey(mode.name))
                                    }
                                    .onMove { from, to in
                                        settings.splatoon3ShiftOrder.move(fromOffsets: from, toOffset: to)
                                    }
                                }
                            }
                            Section(LocalizedStringKey("splatoon_2")) {
                                List {
                                    ForEach(settings.splatoon2ScheduleOrder, id: \.self) { mode in
                                        Text(LocalizedStringKey(mode.name))
                                    }
                                    .onMove { from, to in
                                        settings.splatoon2ScheduleOrder.move(fromOffsets: from, toOffset: to)
                                    }
                                }
                            }
                            Section {
                                List {
                                    ForEach([Splatoon2ShiftMode.salmonRun], id: \.self) { mode in
                                        Text(LocalizedStringKey(mode.name))
                                    }
                                    .onMove { from, to in
                                        
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
                        AlertKitAPI.present(title: String(localized: "widgets_reloaded"), icon: .done, style: .iOS17AppleMusic, haptic: .success)
                    }
                    Button(LocalizedStringKey("clear_cache")) {
                        KingfisherManager.shared.cache.clearMemoryCache()
                        KingfisherManager.shared.cache.clearDiskCache()
                        AlertKitAPI.present(title: String(localized: "cache_cleared"), icon: .done, style: .iOS17AppleMusic, haptic: .success)
                    }
                }
                Section(LocalizedStringKey("about")) {
                    HStack {
                        Text(LocalizedStringKey("version"))
                        
                        Spacer()
                        
                        Text(version)
                    }
                    SafariButton(title: String(localized: "source_code_repository"), url: URL(string: "https://github.com/zhxie/Ikachan")!)
                    SafariButton(title: String(localized: "privacy_policy"), url: URL(string: "https://github.com/zhxie/Ikachan/wiki/Privacy-Policy")!)
                    SafariButton(title: String(format: "%@ %@", String(localized: "developer"), "@xzh_Sketch"), url: URL(string: "https://weibo.com/u/2269567390")!)
                    SafariButton(title: String(format: "%@ %@", String(localized: "designer"), "@贝壳牌砂糖"), url: URL(string: "https://weibo.com/u/6622470330")!)
                }
                Section {
                    SafariButton(title: "@瑞恩呗", url: URL(string: "https://weibo.com/u/1731761185")!)
                    SafariButton(title: "@thepantalion", url: URL(string: "https://x.com/thepantalion")!)
                    SafariButton(title: "Splatoon2.ink", url: URL(string: "https://splatoon2.ink/")!)
                    SafariButton(title: "Splatoon3.ink", url: URL(string: "https://splatoon3.ink/")!)
                    SafariButton(title: "imink", url: URL(string: "https://github.com/JoneWang/imink")!)
                    SafariButton(title: "AlertKit", url: URL(string: "https://github.com/sparrowcode/AlertKit/blob/v5/LICENSE")!)
                    SafariButton(title: "Kingfisher", url: URL(string: "https://github.com/onevcat/Kingfisher/blob/master/LICENSE")!)
                    SafariButton(title: "SwiftyJSON", url: URL(string: "https://github.com/SwiftyJSON/SwiftyJSON/blob/master/LICENSE")!)
                } header: {
                    Text(LocalizedStringKey("acknowledgements"))
                } footer: {
                    Text(LocalizedStringKey("disclaimer"))
                }
            }
            .navigationTitle(LocalizedStringKey("ikachan"))
            .toolbar {
                ToolbarItem {
                    Button {
                        dismiss()
                    } label: {
                        if #available(iOS 26.0, *) {
                            Image(systemName: "xmark")
                        } else {
                            Text(LocalizedStringKey("close"))
                        }
                    }
                }
            }
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
