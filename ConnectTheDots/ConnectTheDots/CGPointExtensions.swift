import UIKit

extension CGPoint {
    func sharesAxis(with other: CGPoint?) -> Bool {
        guard let other = other else { return false }
        return x == other.x || y == other.y
    }
}
