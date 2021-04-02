import UIKit

class DotsContainerCanvas: UIView {
    var connectedPoints: [CGPoint] = []
    var startPoint: CGPoint?
    var currentPoint: CGPoint?
    var strokeColor: UIColor?

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        guard let strokeColor = strokeColor,
              let startPoint = startPoint,
              let currentPoint = currentPoint,
              let context = UIGraphicsGetCurrentContext()
        else { return }

        context.setStrokeColor(strokeColor.cgColor)
        context.setLineWidth(10)
        context.setLineCap(.round)
        context.setLineJoin(.bevel)
        context.move(to: startPoint)
        context.addLines(between: connectedPoints)
        context.addLine(to: currentPoint)
        context.strokePath()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchPoint = touch.location(in: self)
        guard let dotView = hitTest(touchPoint, with: event) as? CircularView else { return }
        startPoint = dotView.superview?.convert(dotView.center, to: self)
        currentPoint = startPoint
        strokeColor = dotView.backgroundColor
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        defer { setNeedsDisplay() }

        let touchPoint = touch.location(in: self)
        if let dotView = hitTest(touchPoint, with: event) as? CircularView, dotView.backgroundColor == strokeColor {
            let dotCenter = dotView.superview!.convert(dotView.center, to: self)
            if !connectedPoints.contains(dotCenter) {
                if dotCenter.sharesAxis(with: connectedPoints.last ?? currentPoint) {
                    connectedPoints.append(dotCenter)
                    currentPoint = dotCenter
                    return
                }
            }
        }
        currentPoint = touchPoint
    }

    override func touchesEnded(_: Set<UITouch>, with _: UIEvent?) {
        connectedPoints.removeAll()
        startPoint = nil
        currentPoint = nil
        strokeColor = nil
        setNeedsDisplay()
    }
}
