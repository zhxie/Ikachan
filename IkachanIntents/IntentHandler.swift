import Intents

class IntentHandler: INExtension {
    override func handler(for intent: INIntent) -> Any {
        if intent is Splatoon2ScheduleIntent {
            return Splatoon2ScheduleIntentHandler()
        } else if intent is Splatoon2ShiftIntent {
            return Splatoon2ShiftIntentHandler()
        } else if intent is Splatoon3ScheduleIntent {
            return Splatoon3ScheduleIntentHandler()
        } else if intent is Splatoon3ShiftIntent {
            return Splatoon3ShiftIntentHandler()
        } else {
            return self
        }
    }
}
