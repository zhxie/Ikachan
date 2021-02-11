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
                
                VStack(spacing: 0) {
                    Spacer()
                        .frame(height: 20)

                    VStack(spacing: 2) {
                        Rectangle()
                            .frame(height: 4)
                        
                        Rectangle()
                            .frame(height: 1)
                    }
                    
                    VStack {
                        Text(omikuji.fortune.description)
                            .font(Font.custom(fortuneFontFamily, size: fortuneFontSize))
                            .fontWeight(.black)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.vertical)
                    
                    VStack(spacing: 2) {
                        Rectangle()
                            .frame(height: 1)
                        
                        Rectangle()
                            .frame(height: 4)
                    }
                    
                    Spacer()
                        .frame(height: 20)
                    
                    if omikuji.image.isEmpty {
                        Rectangle()
                            .aspectRatio(1, contentMode: .fit)
                            .foregroundColor(Color(UIColor.secondarySystemBackground))
                            .cornerRadius(15.0)
                            .overlay(
                                Image(omikuji.fortune.defaultImage)
                                    .resizable()
                                    .accessibility(label: Text(omikuji.fortune.description))
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 150)
                            )
                    } else {
                        Image(omikuji.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(15.0)
                    }
                    
                    
                    Spacer()
                    
                    Text(omikuji.description)
                        .font(Font.custom(descriptionFontFamily, size: 24.0))
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                }
                .padding(.horizontal)
                .frame(width: 300, height: 600)
                .background(Color(UIColor.systemBackground))
                .cornerRadius(15.0)
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
            return 84.0
        case "en":
            return 48.0
        default:
            return 48.0
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
