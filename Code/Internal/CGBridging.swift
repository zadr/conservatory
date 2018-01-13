import CoreGraphics

internal extension BlendMode {
	internal var CGBlendView: CGBlendMode {
		switch self {
		case .normal: return .normal
		case .multiply: return .multiply
		case .screen: return .screen
		case .overlay: return .overlay
		case .darken: return .darken
		case .lighten: return .lighten
		case .colorDodge: return .colorDodge
		case .colorBurn: return .colorBurn
		case .softLight: return .softLight
		case .hardLight: return .hardLight
		case .difference: return .difference
		case .exclusion: return .exclusion
		case .hue: return .hue
		case .saturation: return .saturation
		case .color: return .color
		case .luminosity: return .luminosity
		}
	}
}

internal extension Color {
	internal var CGColorView: CGColor {
		let rgbView = RGBView
		let components = [ CGFloat(rgbView.red), CGFloat(rgbView.green), CGFloat(rgbView.blue), CGFloat(AView) ]
		return CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: components)!
	}
}

internal extension GradientOptions {
	internal var CGGradientDrawingOptionsView: CGGradientDrawingOptions {
		var optionsList = [CGGradientDrawingOptions]()
		if beforeScene {
			optionsList.append(.drawsBeforeStartLocation)
		}

		if afterScene {
			optionsList.append(.drawsAfterEndLocation)
		}

		return CGGradientDrawingOptions(rawValue: optionsList.reduce(0, {
			return $0 | $1.rawValue
		}))
	}
}

internal extension Point {
	internal init(x: CGFloat, y: CGFloat) {
		self.init(x: Double(x), y: Double(y))
	}

	internal init(point: CGPoint) {
		self.init(x: Double(point.x), y: Double(point.y))
	}

	internal var CGPointView: CGPoint {
		return CGPoint(x: CGFloat(x), y: CGFloat(y))
	}
}

internal extension Size {
	internal init(width: CGFloat, height: CGFloat) {
		self.init(width: Double(width), height: Double(height))
	}

	internal init(size: CGSize) {
		self.init(width: Double(size.width), height: Double(size.height))
	}

	internal var CGSizeView: CGSize {
		return CGSize(width: CGFloat(width), height: CGFloat(height))
	}
}

internal extension Box {
	internal var CGRectView: CGRect {
		let point = location.CGPointView
		let dimension = size.CGSizeView

		return CGRect(x: point.x, y: point.y, width: dimension.width, height: dimension.height)
	}
}

internal extension Transform {
	internal var CGAffineTransformView: CGAffineTransform {
		return CGAffineTransform(a: CGFloat(a), b: CGFloat(b), c: CGFloat(c), d: CGFloat(d), tx: CGFloat(tx), ty: CGFloat(ty))
	}
}

internal extension Bezier {
	internal var CGPathView: CGPath {
		let path = CGMutablePath()

		forEach { (segment) in
			switch segment {
			case .move(let to):
				path.move(to: to.CGPointView)
			case .line(let to):
				path.addLine(to: to.CGPointView)
			case .arc(let center, let radius, let start, let end):
				path.addArc(center: center.CGPointView, radius: CGFloat(radius), startAngle: CGFloat(start), endAngle: CGFloat(end), clockwise: true)
			case .curve(let point, let controlPoint1, let controlPoint2):
				path.addCurve(to: point.CGPointView, control1: controlPoint1.CGPointView, control2: controlPoint2.CGPointView)
			case .quadCurve(let point, let controlPoint):
				path.addQuadCurve(to: point.CGPointView, control: controlPoint.CGPointView)
			case .close:
				path.closeSubpath()
			}
		}

		return path.copy()!
	}
}
