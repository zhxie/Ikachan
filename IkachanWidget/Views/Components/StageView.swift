//
//  StageView.swift
//  IkachanWidget
//
//  Created by Sketch on 2021/11/30.
//

import SwiftUI
import Kingfisher

struct StageView: View {
    let stage: Stage
    
    var body: some View {
        Rectangle()
            .fill(Color(UIColor.secondarySystemBackground))
            .overlay (
                KFImage(URL(string: stage.thumbnailUrl)!)
                    .placeholder {
                        Rectangle()
                            .foregroundColor(Color(UIColor.secondarySystemBackground))
                    }
                    .resizedToFill()
                    .clipped()
                    .accessibilityLabel(LocalizedStringKey(stage.name))
            )
            .cornerRadius(7.5)
    }
}

struct StageView_Previews: PreviewProvider {
    static var previews: some View {
        StageView(stage: Splatoon2ScheduleStage.theReef)
    }
}
