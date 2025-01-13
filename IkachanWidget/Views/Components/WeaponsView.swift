import SwiftUI
import Kingfisher

struct WeaponView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var weapon: Weapon
    var accented: Bool
    
    var body: some View {
        if colorScheme == .light && weapon.image.absoluteString.contains("a23d035e2f37c502e85b6065ba777d93f42d6ca7017ed029baac6db512e3e17f") && !accented {
            Image(uiImage: UIImage(contentsOfFile: ImageCache.default.cachePath(forKey: (weapon.thumbnail ?? weapon.image).cacheKey)) ?? UIImage())
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipped()
                .colorInvert()
                .accessibilityLabel(weapon.name)
        } else {
#if os(watchOS)
            // HACK: We cannot use the following easier method to load an cached image on watchOS. It may be a bug of watchOS.
            Image(uiImage: UIImage(data: Data(referencing: NSData(contentsOfFile: ImageCache.default.cachePath(forKey: (weapon.thumbnail ?? weapon.image).cacheKey)) ?? NSData())) ?? UIImage())
                .resizable()
                .widgetAccentedRenderingMode_Backport(.accentedDesaturated)
                .aspectRatio(contentMode: .fill)
                .clipped()
                .accessibilityLabel(weapon.name)
#else
            Image(uiImage: UIImage(contentsOfFile: ImageCache.default.cachePath(forKey: (weapon.thumbnail ?? weapon.image).cacheKey)) ?? UIImage())
                .resizable()
                .widgetAccentedRenderingMode_Backport(.accentedDesaturated)
                .aspectRatio(contentMode: .fill)
                .clipped()
                .accessibilityLabel(weapon.name)
#endif
        }
    }
}

struct WeaponsView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var weapons: [Weapon]
    var accented: Bool
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(weapons, id: \.name) { weapon in
                Color.clear
                    .aspectRatio(1, contentMode: .fit)
                    .overlay(
                        WeaponView(weapon: weapon, accented: accented)
                    )
                    .cornerRadius(8)
            }
        }
    }
}

#Preview {
    WeaponsView(weapons: [PreviewWeapon, PreviewWeapon, PreviewWeapon, PreviewWeapon], accented: false)
}
