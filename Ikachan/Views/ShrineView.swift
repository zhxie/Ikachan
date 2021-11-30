//
//  ShrineView.swift
//  Ikachan
//
//  Created by Sketch on 2021/2/6.
//

import SwiftUI

struct ShrineView: View {
    @Binding var showModal: Bool
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(UIColor.secondarySystemBackground)
                    .ignoresSafeArea(edges: .all)
                
                GeometryReader { g in
                    if g.size.height < 600 {
                        ScrollView {
                            omikujiView
                        }
                    } else {
                        VStack {
                            Spacer()
                                .frame(minHeight: 0)
                            
                            HStack {
                                Spacer()
                                    .frame(minWidth: 0)
                                
                                omikujiView
                                    .layoutPriority(1)
                                
                                Spacer()
                                    .frame(minWidth: 0)
                            }
                            .layoutPriority(1)
                        
                            Spacer()
                                .frame(minHeight: 0)
                        }
                    }
                }
                .navigationTitle("ika_shrine")
                .navigationBarItems(trailing: Button("close") {
                    showModal.toggle()
                })
            }
        }
    }
    
    var omikuji: Omikuji {
        fortune()
    }
    
    var omikujiView: some View {
        VStack(spacing: 0) {
            Spacer()
                .frame(height: 20)
                .layoutPriority(1)

            VStack(spacing: 2) {
                Rectangle()
                    .frame(height: 4)
                
                Rectangle()
                    .frame(height: 1)
            }
            .layoutPriority(1)
            
            VStack {
                Text(LocalizedStringKey(omikuji.fortune.description))
                    .font(Font.custom(fortuneFontFamily, size: fortuneFontSize))
                    .fontWeight(.black)
                    .multilineTextAlignment(.center)
            }
            .padding(.vertical)
            .layoutPriority(1)
            
            VStack(spacing: 2) {
                Rectangle()
                    .frame(height: 1)
                
                Rectangle()
                    .frame(height: 4)
            }
            .layoutPriority(1)
            
            Spacer()
                .frame(height: 20)
                .layoutPriority(1)
            
            if omikuji.image.isEmpty {
                Rectangle()
                    .aspectRatio(1, contentMode: .fit)
                    .foregroundColor(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(15)
                    .overlay(
                        Image(omikuji.fortune.defaultImage)
                            .resizedToFit()
                            .frame(width: 150)
                            .accessibility(label: Text(LocalizedStringKey(omikuji.fortune.description)))
                    )
                    .layoutPriority(1)
            } else {
                Image(omikuji.image)
                    .resizedToFit()
                    .cornerRadius(15)
                    .layoutPriority(1)
            }
            
            Spacer()
            
            Text(LocalizedStringKey(omikuji.description))
                .font(Font.custom(descriptionFontFamily, size: 24))
                .multilineTextAlignment(.center)
            
            Spacer()
        }
        .padding(.horizontal)
        .frame(idealWidth: 300, maxWidth: 300, idealHeight: 600, maxHeight: 600)
        .background(Color(UIColor.systemBackground))
        .cornerRadius(15)
        .padding()
    }
    
    var locale: String {
        Bundle.main.preferredLocalizations.first!
    }
    
    var fortuneFontFamily: String {
        switch locale {
        case "ja", "zh-Hans":
            return "Hiragino Mincho ProN"
        case "en":
            return "Times New Roman"
        default:
            return "Times New Roman"
        }
    }
    
    var fortuneFontSize: CGFloat {
        switch locale {
        case "ja", "zh-Hans":
            return 84
        case "en":
            return 48
        default:
            return 48
        }
    }
    
    var descriptionFontFamily: String {
        switch locale {
        case "ja":
            return "Hiragino Mincho ProN"
        case "zh-Hans":
            return "Songti SC"
        case "en":
            return "Times New Roman"
        default:
            return "Times New Roman"
        }
    }
}

struct ShrineView_Previews: PreviewProvider {
    static var previews: some View {
        ShrineView(showModal: .constant(true))
    }
}
