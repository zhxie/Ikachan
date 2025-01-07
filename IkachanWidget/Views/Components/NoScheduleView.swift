import SwiftUI
import WidgetKit

struct NoScheduleView: View {
    var body: some View {
        Spacer()
        
        Text(LocalizedStringKey("no_schedules"))
            .font(.subheadline)
            .foregroundColor(.secondary)
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity, alignment: .center)
        
        Spacer()
    }
}

@available(iOSApplicationExtension 17.0, watchOSApplicationExtension 10.0, *)
struct NoScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        NoScheduleView()
            .containerBackground(for: .widget, content: {})
    }
}
