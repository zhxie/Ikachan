//
//  CurrentView.swift
//  Ikachan
//
//  Created by Sketch on 2021/1/19.
//

import SwiftUI

struct CurrentView: View {
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        ScrollView() {
            VStack(spacing: 60) {
                if let schedule = regular {
                    VStack(spacing: 15) {
                        HStack {
                            VStack(alignment: .leading, spacing: 0) {
                                Text(schedule.gameMode.longDescription)
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.secondary)
                                Text(schedule.rule.description)
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.primary)
                                    .lineLimit(1)
                            }
                            .layoutPriority(1)
                            
                            Spacer()
                            
                            Image(schedule.rule.rawValue)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                        }
                        .padding(.horizontal)
                        
                        VStack(spacing: 20) {
                            CardView(image: Splatnet2URL + schedule.stageA.image, title: schedule.stageA.description)
                            CardView(image: Splatnet2URL + schedule.stageB.image, title: schedule.stageB.description)
                        }
                    }
                }
                
                if let schedule = ranked {
                    VStack(spacing: 15) {
                        HStack {
                            VStack(alignment: .leading, spacing: 0) {
                                Text(schedule.gameMode.longDescription)
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.secondary)
                                Text(schedule.rule.description)
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.primary)
                                    .lineLimit(1)
                            }
                            .layoutPriority(1)
                            
                            Spacer()
                            
                            Image(schedule.rule.rawValue)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                        }
                        .padding(.horizontal)
                        
                        VStack(spacing: 20) {
                            CardView(image: Splatnet2URL + schedule.stageA.image, title: schedule.stageA.description)
                            CardView(image: Splatnet2URL + schedule.stageB.image, title: schedule.stageB.description)
                        }
                    }
                }
                
                if let schedule = league {
                    VStack(spacing: 15) {
                        HStack {
                            VStack(alignment: .leading, spacing: 0) {
                                Text(schedule.gameMode.longDescription)
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.secondary)
                                Text(schedule.rule.description)
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.primary)
                                    .lineLimit(1)
                            }
                            .layoutPriority(1)
                            
                            Spacer()
                            
                            Image(schedule.rule.rawValue)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                        }
                        .padding(.horizontal)
                        
                        VStack(spacing: 20) {
                            CardView(image: Splatnet2URL + schedule.stageA.image, title: schedule.stageA.description)
                            CardView(image: Splatnet2URL + schedule.stageB.image, title: schedule.stageB.description)
                        }
                    }
                }
                
                if let shift = shift {
                    VStack(spacing: 15) {
                        HStack {
                            VStack(alignment: .leading, spacing: 0) {
                                Text("salmon_run")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.secondary)
                                Text(title(startTime: shift.startTime))
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.primary)
                                    .lineLimit(1)
                            }
                            .layoutPriority(1)
                            
                            Spacer()
                            
                            Image("salmon_run")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                        }
                        .padding(.horizontal)
                        
                        XCardView(image: Splatnet2URL + shift.stage!.image.rawValue, title: shift.stage!.description, subimages: mapWeaponImage(weapons: shift.weapons))
                        
                        Spacer()
                            .frame(height: 45)
                    }
                }
            }
            .padding(.vertical)
        }
        .onAppear(perform: update)
    }
    
    var regular: Schedule? {
        modelData.schedules.filter { schedule in
            schedule.gameMode == Schedule.GameMode.regular
        }
        .first
    }
    
    var ranked: Schedule? {
        modelData.schedules.filter { schedule in
            schedule.gameMode == Schedule.GameMode.gachi
        }
        .first
    }
    
    var league: Schedule? {
        modelData.schedules.filter { schedule in
            schedule.gameMode == Schedule.GameMode.league
        }
        .first
    }
    
    var shift: Shift? {
        modelData.shifts.filter { shift in
            shift.stage != nil
        }
        .first
    }
    
    func title(startTime: Date) -> String {
        let current = Date()
        
        if startTime < current {
            return "open"
        } else {
            return "soon"
        }
    }
    
    func mapWeaponImage(weapons: [Weapon]) -> [String] {
        var result: [String] = []
        
        for weapon in weapons {
            result.append(Splatnet2URL + weapon.image)
        }
        
        return result
    }
    
    func update() {
        modelData.updateSchedules()
        modelData.updateShifts()
    }
}

struct CurrentView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentView()
            .environmentObject(ModelData())
    }
}
