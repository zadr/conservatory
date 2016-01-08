import CoreGraphics
import ImageIO
#if os(iOS)
import MobileCoreServices
#elseif os(OSX)
import CoreServices
#endif

public extension Image {
	public init(image: CGImageRef) {
		// todo: support non-RGBA pixel ordering so these preconditions can go away
		precondition(CGColorSpaceGetModel(CGImageGetColorSpace(image)) == .RGB, "Unable to initalize Image with non-RGB images")
		precondition(CGImageGetAlphaInfo(image) == .PremultipliedLast, "Unable to initalize Image without alpha component at end")

		let data = CGDataProviderCopyData(CGImageGetDataProvider(image))
		let bytes = CFDataGetBytePtr(data)
		let size = Size(width: CGImageGetWidth(image), height: CGImageGetHeight(image))

		self.init(data: bytes, size: size)
	}

	internal var CGImage: CGImageRef {
		get {
			let bytes = UnsafeMutablePointer<Void>(storage)
			let context = CGBitmapContextCreate(bytes, Int(size.width), Int(size.height), 8, 4 * Int(size.width), CGColorSpaceCreateDeviceRGB(), CGImageAlphaInfo.PremultipliedLast.rawValue)
			return CGBitmapContextCreateImage(context)!
		}
	}
}

// MARK: -

// todo: move this to somewhere public
extension CGImageRef: ImageConvertible {
	private func data(format: CFString) -> UnsafePointer<UInt8> {
		let data = CFDataCreateMutable(nil, 0)
		let destination = CGImageDestinationCreateWithData(data, format, 1, nil)!
		CGImageDestinationAddImage(destination, self, nil)
		CGImageDestinationFinalize(destination)
		return CFDataGetBytePtr(data)
	}

	public var bitmapView: UnsafePointer<UInt8> {
		get {
			return data(kUTTypeBMP)
		}
	}

	public var JPEGView: UnsafePointer<UInt8> {
		get {
			return data(kUTTypeJPEG)
		}
	}

	public var PNGView: UnsafePointer<UInt8> {
		get {
			return data(kUTTypePNG)
		}
	}
}

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

	internal init(point: CGSize) {
		self.init(width: Double(point.width), height: Double(point.height))
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
