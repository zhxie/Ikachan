import SwiftUI
import WidgetKit

struct NoShiftView: View {
    var body: some View {
        Spacer()
        
        Text(LocalizedStringKey("no_shift"))
            .font(.subheadline)
            .foregroundColor(.secondary)
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity, alignment: .center)
        
        Spacer()
    }
}

@available(iOSApplicationExtension 17.0, *)
struct NoShiftView_Previews: PreviewProvider {
    static var previews: some View {
        NoShiftView()
            .containerBackground(for: .widget, content: {})
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
