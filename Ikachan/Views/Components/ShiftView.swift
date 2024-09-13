import SwiftUI

struct ShiftView: View {
    var shift: Shift
    var nextShift: Shift? = nil
    var backgroundColor = Color(.secondarySystemBackground)
    var shrinkToFit = false
    
    var stageAndWeapons: some View {
        HStack {
            StageView(stage: shift.stage!, backgroundColor: backgroundColor, style: shrinkToFit ? .List : .Home)
            VStack {
                if let kingSalmonid = shift.kingSalmonid {
                    HStack {
                        if let image = kingSalmonid.image {
                            Image(image)
                                .resizedToFit()
                                .frame(width: 20, height: 20)
                        }
                        Text(kingSalmonid.name)
                            .lineLimit(1)
                    }
                }
                
                WeaponsView(weapons: shift.weapons!)
                    .padding(8)
            }
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Image(shift.mode.image)
                    .resizedToFit()
                    .frame(width: 16, height: 16)
                    .layoutPriority(1)
                Text(LocalizedStringKey(shift.mode.name))
                    .fontWeight(.bold)
                    .lineLimit(1)
                
                Spacer()
                
                Text(timeSpan(start: shift.startTime, end: shift.endTime))
                    .monospacedDigit()
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                    .layoutPriority(1)
            }
            
            if shift.stage != nil {
                HStack {
                    if shrinkToFit {
                        Spacer()
                            .frame(width: 16)
                            .layoutPriority(1)
                        
                        Spacer()
                        
                        stageAndWeapons
                    } else {
                        HStack {
                            Rectangle()
                                .fill(.clear)
                                .aspectRatio(16 / 9, contentMode: .fit)
                            Rectangle()
                                .fill(.clear)
                                .aspectRatio(16 / 9, contentMode: .fit)
                        }
                        .overlay {
                            stageAndWeapons
                        }
                    }
                }
            }
            
            if let shift = nextShift {
                if let stage = shift.stage {
                    HStack {
                        Text(LocalizedStringKey("next"))
                            .font(.footnote)
                            .fontWeight(.bold)
                            .foregroundColor(Color(.systemBackground))
                            .padding(4)
                            .background {
                                shift.mode.accentColor
                                    .cornerRadius(4)
                            }
                            .layoutPriority(1)
                        
                        Spacer()
                        
                        Text(stage.name)
                            .font(.footnote)
                        
                        WeaponsView(weapons: shift.weapons!)
                            .frame(height: 20)
                            .layoutPriority(1)
                    }
                    // HACK: I do not know why but we need this padding to make spacing in the VStack equal.
                    .padding([.top], 2)
                }
            }
        }
    }
}

#Preview {
    ShiftView(shift: PreviewSplatoon3Shift, nextShift: PreviewSplatoon2Shift)
}
