import AppKit

internal extension Transform {
	internal var NSAffineTransformView: NSAffineTransform {
		get {
			let transformStruct = NSAffineTransformStruct(m11: CGFloat(a), m12: CGFloat(b), m21: CGFloat(c), m22: CGFloat(d), tX: CGFloat(tx), tY: CGFloat(ty))
			let transform = NSAffineTransform()
			transform.transformStruct = transformStruct
			return transform
		}
	}
}

internal extension Bezier {
	internal var NSBezierPathView: NSBezierPath {
		get {
			let path = NSBezierPath()

			segments.forEach({
				switch $0 {
				case .Move(let to):
					path.moveToPoint(to.CGPointView)
				case .Line(let to):
					path.lineToPoint(to.CGPointView)
				case .Arc(let center, let radius, let start, let end):
					path.appendBezierPathWithArcWithCenter(center.CGPointView, radius: CGFloat(radius), startAngle: CGFloat(start), endAngle: CGFloat(end), clockwise: true)
				case .Curve(let point, let controlPoint1, let controlPoint2):
					path.curveToPoint(point.CGPointView, controlPoint1: controlPoint1.CGPointView, controlPoint2: controlPoint2.CGPointView)
				case .QuadCurve(_, _):
					precondition(false, "Unable to append quad curve to NSBezierPath")
				case .Close:
					path.closePath()
				}
			})

			return path
		}
	}
}
