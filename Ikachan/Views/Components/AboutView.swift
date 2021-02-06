//
//  AboutView.swift
//  Ikachan
//
//  Created by Sketch on 2021/1/22.
//

import SwiftUI
import WidgetKit
import Kingfisher

struct AboutView: View {
    @Binding var showModal: Bool
    
    @State var isDownloadingAllResources = false
    @State var progressValue = 0.0
    @State var progressTotal = 0.0
    
    @State var showShrine: Bool = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("support")) {
                    ZStack {
                        HStack {
                            Button("download_all_resources") {
                                var urls: Set<String> = []
                                var resources: [Resource] = []
                                
                                for stage in Schedule.Stage.StageId.allCases {
                                    urls.insert(Splatnet2URL + stage.defaultURL)
                                }
                                for stage in Shift.Stage.StageImage.allCases {
                                    urls.insert(Splatnet2URL + stage.defaultURL)
                                }
                                for weapon in Weapon.WeaponId.allCases {
                                    urls.insert(Splatnet2URL + weapon.defaultURL)
                                }
                                
                                progressValue = 0
                                progressTotal = Double(urls.count)
                                isDownloadingAllResources = true

                                for url in urls {
                                    resources.append(ImageResource(downloadURL: URL(string: url)!))
                                }
                                ImagePrefetcher(resources: resources, progressBlock: { (skipped, failed, completed) in
                                    self.progressValue = Double(skipped.count + failed.count + completed.count)
                                }) { (_, _, _) in
                                    self.isDownloadingAllResources = false
                                }
                                .start()
                            }
                            .disabled(isDownloadingAllResources)
                            
                            Spacer()
                        }
                        
                        HStack {
                            Spacer()
                            
                            if isDownloadingAllResources {
                                ProgressView(value: progressValue, total: progressTotal)
                                    .frame(minWidth: 50, maxWidth: 100)
                            }
                        }
                    }
                    Button("reload_widgets") {
                        WidgetCenter.shared.reloadAllTimelines()
                    }
                    .disabled(isDownloadingAllResources)
                    Button("clear_cache") {
                        KingfisherManager.shared.cache.clearMemoryCache()
                        KingfisherManager.shared.cache.clearDiskCache()
                    }
                    .disabled(isDownloadingAllResources)
                }
                
                Section(header: Text("about")) {
                    Link("repository", destination: URL(string: "https://github.com/zhxie/ikachan")!)
                    Link("developer_sketch", destination: URL(string: isChinese ? "https://weibo.com/u/2269567390" : "https://twitter.com/xzh1206")!)
                    Link("designer_shooky", destination: URL(string: isChinese ? "https://weibo.com/u/6622470330" : "https://twitter.com/ShellShooky")!)
                }
                
                Section(header: Text("data_source")) {
                    Link("splatoon2_ink", destination: URL(string: "https://splatoon2.ink/")!)
                }
                
                Section(footer: Text("disclaimer")) {
                    NavigationLink(destination: ScrollView {
                        VStack(alignment: .leading) {
                            VStack(alignment: .leading) {
                                Text("Kingfisher")
                                    .bold()
                                
                                Text(license_kingfisher)
                            }
                            
                            VStack(alignment: .leading) {
                                Text("SwiftyJSON")
                                    .bold()
                                
                                Text(license_swifty_json)
                            }
                        }
                        .navigationTitle("acknowledgements")
                        .navigationBarItems(trailing: Button("close") {
                            showModal.toggle()
                        })
                        .padding()
                    }) {
                        Text("acknowledgements")
                    }
                }
                
                Section(footer: HStack {
                    Spacer()
                    
                    VStack {
                        Image("inkling.splat")
                            .accessibility(label: Text("ika_shrine"))
                            .font(Font.system(size: 96))
                            .foregroundColor(.secondary)
                            .onReceive(NotificationCenter.default.publisher(for: .deviceDidShakeNotification)) { _ in
                                if !showShrine {
                                    Impact(style: .medium)
                                    
                                    showShrine.toggle()
                                }
                            }
                            .onTapGesture {
                                Impact(style: .light)
                                
                                showShrine.toggle()
                            }
                        
                        Text(String(format: "%@ %@", NSLocalizedString("version", comment: ""), version))
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                }) {
                    EmptyView()
                }
            }
            .navigationTitle("ikachan")
            .navigationBarItems(trailing: Button("close") {
                showModal.toggle()
            })
        }
        .sheet(isPresented: $showShrine) {
            ShrineView(showModal: $showShrine)
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
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView(showModal: .constant(true))
    }
}
