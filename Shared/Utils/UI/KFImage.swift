import SwiftUI
import Kingfisher

extension KFImage {
    func resizedToFit(_ aspectRatio: CGFloat? = nil) -> some View {
        return self
            .resizable()
            .aspectRatio(aspectRatio, contentMode: .fit)
    }
    
    func resizedToFill(_ aspectRatio: CGFloat? = nil) -> some View {
        return self
            .resizable()
            .aspectRatio(aspectRatio, contentMode: .fill)
    }
}
