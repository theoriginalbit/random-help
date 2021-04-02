import UIKit

class CircularView: UIView {
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)

        layer.cornerRadius = bounds.size.width / 2
    }
}
