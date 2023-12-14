import SwiftyJSON

extension JSON {
    var isNull: Bool {
        if let _ = self.null {
            return true
        }
        
        return false
    }
}
