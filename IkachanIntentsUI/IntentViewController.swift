//
//  IntentViewController.swift
//  IkachanIntentsUI
//
//  Created by Sketch on 2021/2/2.
//

import SwiftUI
import IntentsUI

class IntentViewController: UIViewController, INUIHostedViewControlling {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func configureView(for parameters: Set<INParameter>, of interaction: INInteraction, interactiveBehavior: INUIInteractiveBehavior, context: INUIHostedViewContext, completion: @escaping (Bool, Set<INParameter>, CGSize) -> Void) {
        let data = interaction.intentResponse?.userActivity?.userInfo
        let scheduleData = data?["schedule"] as? String ?? nil
        let shiftData = data?["shift"] as? String ?? nil
        
        if let scheduleData = scheduleData {
            let decoder = JSONDecoder()
            let schedule = try! decoder.decode(Schedule.self, from: Data(base64Encoded: scheduleData)!)
            
            let controller = UIHostingController(rootView: ScheduleView(schedule: schedule).animation(.default).padding())
            addChild(controller)
            controller.view.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(controller.view)
            controller.didMove(toParent: self)
            
            NSLayoutConstraint.activate([
                controller.view.widthAnchor.constraint(equalTo: view.widthAnchor),
                controller.view.heightAnchor.constraint(equalTo: view.heightAnchor),
                controller.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                controller.view.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
            
            completion(true, parameters, desiredSize)
        } else if let shiftData = shiftData {
            let decoder = JSONDecoder()
            let shift = try! decoder.decode(Shift.self, from: Data(base64Encoded: shiftData)!)
            
            let controller = UIHostingController(rootView: ShiftView(shift: shift, title: shift.status).animation(.default).padding())
            addChild(controller)
            controller.view.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(controller.view)
            controller.didMove(toParent: self)
            
            NSLayoutConstraint.activate([
                controller.view.widthAnchor.constraint(equalTo: view.widthAnchor),
                controller.view.heightAnchor.constraint(equalTo: view.heightAnchor),
                controller.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                controller.view.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
            
            completion(true, parameters, desiredSize)
        } else {
            completion(false, parameters, desiredSize)
        }
    }

    var desiredSize: CGSize {
        CGSize(width: extensionContext!.hostedViewMaximumAllowedSize.width, height: 210)
    }
}
