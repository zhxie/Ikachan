//
//  AboutView.swift
//  Ikachan
//
//  Created by Sketch on 2021/1/22.
//

import SwiftUI
import CoreMotion
import WidgetKit
import Intents
import Kingfisher
import SPAlert

struct AboutView: View {
    @Binding var showModal: Bool
    
    @State var isDownloadingAllResources = false
    @State var progressValue: Double = 0
    @State var progressTotal: Double = 0
    
    @State var showShrine = false
    
    let motion = CMMotionManager()
    @State var prevX = Double.nan
    @State var prevY = Double.nan
    @State var prevZ = Double.nan
    @State var impactCount = 0
    @State var stableFrameCount = 0
    @State var timer: Timer? = nil
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("settings")) {
                    Link("language", destination: URL(string: UIApplication.openSettingsURLString)!)
                    Button("siri_and_shortcuts") {
                        let url = URL(string: "shortcuts://")!
                        
                        if UIApplication.shared.canOpenURL(url) {
                            UIApplication.shared.open(url)
                        } else {
                            UIApplication.shared.open(URL(string: "itms-apps://apple.com/app/id915249334")!)
                        }
                    }
                    NavigationLink(destination: ZStack {
                        Color(UIColor.secondarySystemBackground)
                            .ignoresSafeArea(edges: .all)
                        
                        Form {
                            Section {
                                IconView(name: "kuro", iconName: nil, text: "kuro")
                                IconView(name: "ichi", iconName: "ichi", text: "ichi")
                            }
                        }
                        .navigationTitle("app_icon")
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button("close") {
                                    showModal.toggle()
                                }
                            }
                        }
                    }) {
                        Text("app_icon")
                    }
                }
                Section(header: Text("support")) {
                    HStack {
                        Button("download_all_resources") {
                            var urls: Set<String> = []
                            var resources: [Resource] = []
                            
                            for stage in Splatoon2ScheduleStage.allCases {
                                urls.insert(stage.imageUrl)
                            }
                            for stage in Splatoon2ShiftStage.allCases {
                                urls.insert(stage.imageUrl)
                            }
                            for weapon in Splatoon2Weapon.allCases {
                                urls.insert(weapon.imageUrl)
                            }
                            
                            progressValue = 0
                            progressTotal = Double(urls.count)
                            isDownloadingAllResources = true

                            for url in urls {
                                resources.append(ImageResource(downloadURL: URL(string: url)!))
                            }
                            ImagePrefetcher(resources: resources, progressBlock: { (skipped, failed, completed) in
                                progressValue = Double(skipped.count + failed.count + completed.count)
                            }) { (_, _, _) in
                                isDownloadingAllResources = false
                                
                                SPAlert.present(title: "resources_downloaded".localizedString, preset: .done)
                            }
                            .start()
                        }
                        .disabled(isDownloadingAllResources)
                        .layoutPriority(1)
                        
                        Spacer()
                        
                        if isDownloadingAllResources {
                            ProgressView(value: progressValue, total: progressTotal)
                                .frame(maxWidth: 100)
                        }
                    }
                    Button("reload_widgets") {
                        WidgetCenter.shared.reloadAllTimelines()
                        
                        SPAlert.present(title: "widgets_reloaded".localizedString, preset: .done)
                    }
                    .disabled(isDownloadingAllResources)
                    Button("reset_siri_suggestions") {
                        INInteraction.deleteAll()
                        
                        SPAlert.present(title: "siri_suggestions_reset".localizedString, preset: .done)
                    }
                    Button("clear_cache") {
                        KingfisherManager.shared.cache.clearMemoryCache()
                        KingfisherManager.shared.cache.clearDiskCache()
                        
                        SPAlert.present(title: "cache_cleared".localizedString, preset: .done)
                    }
                    .disabled(isDownloadingAllResources)
                }
                
                Section(header: Text("about")) {
                    Link("repository", destination: URL(string: "https://github.com/zhxie/Ikachan")!)
                    Link("privacy_policy", destination: URL(string: "https://github.com/zhxie/Ikachan/wiki/Privacy-Policy")!)
                    Link("developer_sketch", destination: URL(string: isChinese ? "https://weibo.com/u/2269567390" : "https://twitter.com/xzh1206")!)
                    Link("designer_shooky", destination: URL(string: isChinese ? "https://weibo.com/u/6622470330" : "https://twitter.com/ShellShooky")!)
                }
                
                Section(footer: Text("disclaimer")) {
                    NavigationLink(destination: ScrollView {
                        VStack(alignment: .leading) {
                            VStack(alignment: .leading) {
                                HStack {
                                    Link(destination: URL(string: "https://splatoon2.ink/")!) {
                                        Text("Splatoon2.ink")
                                            .bold()
                                    }
                                }
                                
                                Text("")
                            }
                            
                            VStack(alignment: .leading) {
                                HStack {
                                    Link(destination: URL(string: "https://splatoon3.ink/")!) {
                                        Text("Splatoon3.ink")
                                            .bold()
                                    }
                                }
                                
                                Text("")
                            }
                            
                            VStack(alignment: .leading) {
                                Text("Kingfisher")
                                    .bold()
                                
                                Text(license_kingfisher)
                            }
                            
                            VStack(alignment: .leading) {
                                Text("SPAlert")
                                    .bold()
                                
                                Text(license_s_p_alert)
                            }
                            
                            VStack(alignment: .leading) {
                                Text("SwiftyJSON")
                                    .bold()
                                
                                Text(license_swifty_json)
                            }
                        }
                        .navigationTitle("acknowledgements")
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button("close") {
                                    showModal.toggle()
                                }
                            }
                        }
                        .padding()
                    }) {
                        Text("acknowledgements")
                    }
                }
                
                Section(footer: HStack {
                    Spacer()
                    
                    VStack {
                        Image("inkling.splat")
                            .resizedToFit()
                            .foregroundColor(.secondary)
                            .frame(width: 96)
                            .accessibilityLabel("ika_shrine")
                            .onTapGesture {
                                Impact(style: .light)
                                
                                showShrine.toggle()
                            }
                        
                        Text(String(format: "%@ %@", "version".localizedString, version))
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                }) {
                    EmptyView()
                }
            }
            .navigationTitle("ikachan")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("close") {
                        showModal.toggle()
                    }
                }
            }
        }
        .sheet(isPresented: $showShrine) {
            ShrineView(showModal: $showShrine)
        }
        .onAppear {
            if motion.isAccelerometerAvailable {
                motion.accelerometerUpdateInterval = 2 / 60
                motion.startAccelerometerUpdates()
                
                timer = Timer(timeInterval: 2 / 60, repeats: true, block: timeout)
                RunLoop.current.add(timer!, forMode: .default)
            }
        }
        .onDisappear {
            timer?.invalidate()
            timer = nil
            
            motion.stopAccelerometerUpdates()
        }
    }
    
    var isChinese: Bool {
        guard let languageCode = Locale.current.languageCode else {
            return true
        }
        
        return languageCode.contains("zh")
    }
    
    var license_kingfisher: String {
        let path = Bundle.main.path(forResource: "LICENSE.Kingfisher", ofType: "md")!
        
        let fm = FileManager()
        let content = fm.contents(atPath: path)
        
        return String(data: content!, encoding: .utf8)!
    }
    
    var license_s_p_alert: String {
        let path = Bundle.main.path(forResource: "LICENSE.SPAlert", ofType: "md")!
        
        let fm = FileManager()
        let content = fm.contents(atPath: path)
        
        return String(data: content!, encoding: .utf8)!
    }
    
    var license_swifty_json: String {
        let path = Bundle.main.path(forResource: "LICENSE.SwiftyJSON", ofType: "md")!
        
        let fm = FileManager()
        let content = fm.contents(atPath: path)
        
        return String(data: content!, encoding: .utf8)!
    }
    
    var version: String {
        let dictionary = Bundle.main.infoDictionary!
        let version = dictionary["CFBundleShortVersionString"] as! String
        let build = dictionary["CFBundleVersion"] as! String
        
        return String(format: "%@ (%@)", version, build)
    }
    
    func timeout(_: Timer) {
        if !showShrine {
            if let data = motion.accelerometerData {
                let x = data.acceleration.x
                let y = data.acceleration.y
                let z = data.acceleration.z
                
                if !prevX.isNaN && !prevY.isNaN && !prevZ.isNaN {
                    let delta = pow((x - prevX), 2) + pow((y - prevY), 2) + pow((z - prevZ), 2)
                    if delta >= 1 {
                        let rand = Int.random(in: 0...Int(delta))
                        switch rand {
                        case 0..<2:
                            Impact(style: .soft)
                        case 2..<4:
                            Impact(style: .light)
                        case 4..<8:
                            Impact(style: .medium)
                        case 8..<12:
                            Impact(style: .rigid)
                        default:
                            Impact(style: .heavy)
                        }
                        
                        impactCount += 1
                        stableFrameCount = 0
                    } else {
                        if stableFrameCount >= 10 {
                            if impactCount >= 10 {
                                Impact(style: .heavy)
                                
                                showShrine.toggle()
                            } else {
                                impactCount = 0
                                stableFrameCount = 0
                            }
                        }
                        
                        stableFrameCount += 1
                    }
                }
                
                prevX = x
                prevY = y
                prevZ = z
            }
        } else {
            prevX = Double.nan
            prevY = Double.nan
            prevZ = Double.nan
            impactCount = 0
            stableFrameCount = 0
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView(showModal: .constant(true))
    }
}
