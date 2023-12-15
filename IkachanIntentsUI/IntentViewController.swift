import SwiftUI
import IntentsUI

class IntentViewController: UIViewController, INUIHostedViewControlling {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func configureView(for parameters: Set<INParameter>, of interaction: INInteraction, interactiveBehavior: INUIInteractiveBehavior, context: INUIHostedViewContext, completion: @escaping (Bool, Set<INParameter>, CGSize) -> Void) {
        let data = interaction.intentResponse?.userActivity?.userInfo
        let splatoon2ScheduleData = data?["splatoon2Schedule"] as? String ?? nil
        let splatoon2ShiftData = data?["splatoon2Shift"] as? String ?? nil
        let splatoon3ScheduleData = data?["splatoon3Schedule"] as? String ?? nil
        let splatoon3ShiftData = data?["splatoon3Shift"] as? String ?? nil
        if (splatoon2ScheduleData != nil) || (splatoon3ScheduleData != nil) {
            let decoder = JSONDecoder()
            var schedule: Schedule
            if let splatoon2ScheduleData = splatoon2ScheduleData {
                schedule = try! decoder.decode(Splatoon2Schedule.self, from: Data(base64Encoded: splatoon2ScheduleData)!)
            } else {
                schedule = try! decoder.decode(Splatoon3Schedule.self, from: Data(base64Encoded: splatoon3ScheduleData!)!)
            }
            let controller = UIHostingController(rootView: ScheduleView(schedule: schedule, backgroundColor: Color(.systemBackground)).padding())
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
        } else if (splatoon2ShiftData != nil) || (splatoon3ShiftData != nil) {
            let decoder = JSONDecoder()
            var shift: Shift
            if let splatoon2ShiftData = splatoon2ShiftData {
                shift = try! decoder.decode(Splatoon2Shift.self, from: Data(base64Encoded: splatoon2ShiftData)!)
            } else {
                shift = try! decoder.decode(Splatoon3Shift.self, from: Data(base64Encoded: splatoon3ShiftData!)!)
            }
            let controller = UIHostingController(rootView: ShiftView(shift: shift, backgroundColor: Color(.systemBackground)).padding())
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
