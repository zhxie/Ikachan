import SwiftUI
import IntentsUI

class IntentViewController: UIViewController, INUIHostedViewControlling {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func configureView(for parameters: Set<INParameter>, of interaction: INInteraction, interactiveBehavior: INUIInteractiveBehavior, context: INUIHostedViewContext, completion: @escaping (Bool, Set<INParameter>, CGSize) -> Void) {
        var schedule: Schedule? = nil
        var nextSchedule: Schedule? = nil
        var shift: Shift? = nil
        var nextShift: Shift? = nil
        let decoder = JSONDecoder()
        if interaction.intent is Splatoon2ScheduleIntent {
            let current = interaction.intentResponse?.userActivity?.userInfo?["current"] as? String ?? nil
            if let current = current {
                schedule = try! decoder.decode(Splatoon2Schedule.self, from: Data(base64Encoded: current)!)
                let next = interaction.intentResponse?.userActivity?.userInfo?["next"] as? String ?? nil
                if let next = next {
                    nextSchedule = try! decoder.decode(Splatoon2Schedule.self, from: Data(base64Encoded: next)!)
                }
            }
        } else if interaction.intent is Splatoon2ShiftIntent {
            let current = interaction.intentResponse?.userActivity?.userInfo?["current"] as? String ?? nil
            if let current = current {
                shift = try! decoder.decode(Splatoon2Shift.self, from: Data(base64Encoded: current)!)
                let next = interaction.intentResponse?.userActivity?.userInfo?["next"] as? String ?? nil
                if let next = next {
                    nextShift = try! decoder.decode(Splatoon2Shift.self, from: Data(base64Encoded: next)!)
                }
            }
        } else if interaction.intent is Splatoon3ScheduleIntent {
            let current = interaction.intentResponse?.userActivity?.userInfo?["current"] as? String ?? nil
            if let current = current {
                schedule = try! decoder.decode(Splatoon3Schedule.self, from: Data(base64Encoded: current)!)
                let next = interaction.intentResponse?.userActivity?.userInfo?["next"] as? String ?? nil
                if let next = next {
                    nextSchedule = try! decoder.decode(Splatoon3Schedule.self, from: Data(base64Encoded: next)!)
                }
            }
        } else if interaction.intent is Splatoon3ShiftIntent {
            let current = interaction.intentResponse?.userActivity?.userInfo?["current"] as? String ?? nil
            if let current = current {
                shift = try! decoder.decode(Splatoon3Shift.self, from: Data(base64Encoded: current)!)
                let next = interaction.intentResponse?.userActivity?.userInfo?["next"] as? String ?? nil
                if let next = next {
                    nextShift = try! decoder.decode(Splatoon3Shift.self, from: Data(base64Encoded: next)!)
                }
            }
        }
        
        if let schedule = schedule {
            let controller = UIHostingController(rootView: ScheduleView(schedule: schedule, nextSchedule: nextSchedule).padding())
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
        } else if let shift = shift {
            let controller = UIHostingController(rootView: ShiftView(shift: shift, nextShift: nextShift).padding())
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
