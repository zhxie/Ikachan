import Foundation

extension Collection {
    func at(index: Index) -> Element? {
        guard indices.contains(index) else {
            return nil
        }
        
        return self[index]
    }
}
