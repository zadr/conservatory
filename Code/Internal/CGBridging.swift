import CoreGraphics

internal extension BlendMode {
	internal var CGBlendView: CGBlendMode {
		switch self {
		case Normal:
			return CGBlendMode.Normal
		case Multiply:
			return CGBlendMode.Multiply
		case Screen:
			return CGBlendMode.Screen
		case Overlay:
			return CGBlendMode.Overlay
		case Darken:
			return CGBlendMode.Darken
		case Lighten:
			return CGBlendMode.Lighten
		case ColorDodge:
			return CGBlendMode.ColorDodge
		case ColorBurn:
			return CGBlendMode.ColorBurn
		case SoftLight:
			return CGBlendMode.SoftLight
		case HardLight:
			return CGBlendMode.HardLight
		case Difference:
			return CGBlendMode.Difference
		case Exclusion:
			return CGBlendMode.Exclusion
		case Hue:
			return CGBlendMode.Hue
		case Saturation:
			return CGBlendMode.Saturation
		case Color:
			return CGBlendMode.Color
		case Luminosity:
			return CGBlendMode.Luminosity
		}
	}
}

internal extension Color {
	internal var CGColorView: CGColorRef {
		get {
			let rgbView = RGBView
			let components = [ CGFloat(rgbView.red), CGFloat(rgbView.green), CGFloat(rgbView.blue), CGFloat(AView) ]
			return CGColorCreate(CGColorSpaceCreateDeviceRGB(), components)!
		}
	}
}

internal extension GradientOptions {
	internal var CGGradientDrawingOptionsView: CGGradientDrawingOptions {
		get {
			var optionsList = [CGGradientDrawingOptions]()
			if beforeScene {
				optionsList.append(.DrawsBeforeStartLocation)
			}

			if afterScene {
				optionsList.append(.DrawsAfterEndLocation)
			}

			return CGGradientDrawingOptions(rawValue: optionsList.reduce(0, combine: {
				return $0 | $1.rawValue
			}))
		}
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
		return CGPointMake(CGFloat(x), CGFloat(y))
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
		return CGSizeMake(CGFloat(width), CGFloat(height))
	}
}

internal extension Transform {
	internal var CGAffineTransformView: CGAffineTransform {
		get {
			return CGAffineTransform(a: CGFloat(a), b: CGFloat(b), c: CGFloat(c), d: CGFloat(d), tx: CGFloat(tx), ty: CGFloat(ty))
		}
	}
}

internal extension Bezier {
	internal var CGPathView: CGPathRef {
		get {
			let path = CGPathCreateMutable()

			segments.forEach({
				switch $0 {
				case .Move(let to):
					CGPathMoveToPoint(path, nil, CGFloat(to.x), CGFloat(to.y))
				case .Line(let to):
					CGPathAddLineToPoint(path, nil, CGFloat(to.x), CGFloat(to.y))
				case .Arc(let center, let radius, let start, let end):
					CGPathAddArc(path, nil, CGFloat(center.x), CGFloat(center.y), CGFloat(radius), CGFloat(start), CGFloat(end), true)
				case .Curve(let point, let controlPoint1, let controlPoint2):
					CGPathAddCurveToPoint(path, nil, CGFloat(controlPoint1.x), CGFloat(controlPoint1.y), CGFloat(controlPoint2.x), CGFloat(controlPoint2.y), CGFloat(point.x), CGFloat(point.y))
				case .QuadCurve(let point, let controlPoint):
					CGPathAddQuadCurveToPoint(path, nil, CGFloat(controlPoint.x), CGFloat(controlPoint.y), CGFloat(point.x), CGFloat(point.y))
				case .Close:
					CGPathCloseSubpath(path)
				}
			})

			return CGPathCreateCopy(path)!
		}
	}
}
