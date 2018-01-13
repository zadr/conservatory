import UIKit

public final class UIViewRenderer: Renderer {
	public typealias RenderResultType = UIView

	public typealias ImageType = UIImage

	public let size: Size

	private var mostRecentSubview: UIView!
	private let view: UIView
	private var backgroundGradientLayers = [UIView: CALayer]()

	private var appearanceStorage = Appearance()
	public init(size: Size = Size(width: 1024.0, height: 768.0)) {
		setenv("CA_DEBUG_TRANSACTIONS", "1", 1)

		self.size = size

		view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: CGFloat(size.width), height: CGFloat(size.height)))
		mostRecentSubview = view
	}

	public func render(_ viewable: Viewable) -> RenderResultType? {
		return render([ viewable ])
	}

	public func render(_ viewables: [Viewable]) -> RenderResultType? {
		viewables.forEach { $0.render(self) }

		UIGraphicsBeginImageContext(size.CGSizeView)
		defer {
			UIGraphicsEndImageContext()
		}

		return view.snapshotView(afterScreenUpdates: true)
	}

	private var encompassingRect: CGRect {
		return view.bounds
	}

	public func draw(_ bezier: Bezier) {
		let UIBezier = UIBezierPath(bezier)
		let nextView = UIView(frame: UIBezier.bounds)

		let shapeLayer = CAShapeLayer()
		shapeLayer.lineWidth = CGFloat(appearanceStorage.borderWidth)
		shapeLayer.path = UIBezier.cgPath
		shapeLayer.fillColor = nil
		shapeLayer.strokeColor = Color.black.CGColorView

		nextView.layer.mask = shapeLayer

		view.addSubview(nextView)

		mostRecentSubview = nextView
	}

	public func draw(_ image: Image) {
		let imageView = UIImageView(image: UIImage(cgImage: image.CGImageView))
		imageView.frame = encompassingRect

		view.addSubview(imageView)
	}

	public func draw(_ text: String, withTextEffects effects: [TextEffect]) {
		let label = UILabel(frame: encompassingRect)
		label.attributedText = text.cocoaValue(effects)

		view.addSubview(label)
	}

	public func apply(_ blendMode: BlendMode) {
		appearanceStorage.blendMode = blendMode
	}

	public func apply(_ border: Palette<Color, GradientOptions>, width: Double) {
		appearanceStorage.border = border
	}

	public func apply(_ background: Palette<Color, GradientOptions>) {
		appearanceStorage.background = background
	}

	public func apply(_ aura: Aura?) {
		appearanceStorage.aura = aura
	}

	public func apply(_ transform: Transform) {
		view.transform = transform.CGAffineTransformView
	}

	public func fill() {
		if let mostRecentSubview = mostRecentSubview {
			switch appearanceStorage.background {
			case .none:
				backgroundGradientLayers[mostRecentSubview]?.removeFromSuperlayer()
				backgroundGradientLayers[mostRecentSubview] = nil
				mostRecentSubview.backgroundColor = nil
			case .solid(let color):
				backgroundGradientLayers[mostRecentSubview]?.removeFromSuperlayer()
				backgroundGradientLayers[mostRecentSubview] = nil
				mostRecentSubview.backgroundColor = color.UIColorView
			case .gradient(let backgroundColors, let options):
				switch options.type {
				case .linear:
					var start = CGPoint(x: view.bounds.midX, y: view.bounds.minY)
					start = start.applying(CGAffineTransform(rotationAngle: CGFloat(options.rotation)))

					var end = CGPoint(x: view.bounds.midX, y: view.bounds.maxY)
					end = end.applying(CGAffineTransform(rotationAngle: CGFloat(options.rotation)))

					let gradientLayer = CAGradientLayer()
					gradientLayer.bounds = view.bounds
					gradientLayer.colors = backgroundColors.map { return $0.CGColorView }
					gradientLayer.locations = backgroundColors.positions.map { return NSNumber(value: $0) }
					gradientLayer.startPoint = start
					gradientLayer.endPoint = end

					mostRecentSubview.layer.insertSublayer(gradientLayer, at: 0)
				case .radial:
					precondition(false, "radial gradients not yet supported with UIViewRenderer")
				}
			}
		}
	}

	public func stroke() {
		if let mostRecentSubview = mostRecentSubview {
			switch appearanceStorage.background {
			case .none:
				backgroundGradientLayers[mostRecentSubview]?.removeFromSuperlayer()
				backgroundGradientLayers[mostRecentSubview] = nil
				mostRecentSubview.backgroundColor = nil
			case .solid(let color):
				backgroundGradientLayers[mostRecentSubview]?.removeFromSuperlayer()
				backgroundGradientLayers[mostRecentSubview] = nil
				mostRecentSubview.backgroundColor = color.UIColorView
			case .gradient(let backgroundColors, let options):
				switch options.type {
				case .linear:
					var start = CGPoint(x: view.bounds.midX, y: view.bounds.minY)
					start = start.applying(CGAffineTransform(rotationAngle: CGFloat(options.rotation)))

					var end = CGPoint(x: view.bounds.midX, y: view.bounds.maxY)
					end = end.applying(CGAffineTransform(rotationAngle: CGFloat(options.rotation)))

					let gradientLayer = CAGradientLayer()
					gradientLayer.bounds = view.bounds
					gradientLayer.colors = backgroundColors.map { return $0.CGColorView }
					gradientLayer.locations = backgroundColors.positions.map { return NSNumber(value: $0) }
					gradientLayer.startPoint = start
					gradientLayer.endPoint = end

					let shapeLayer = CAShapeLayer()
					shapeLayer.lineWidth = CGFloat(appearanceStorage.borderWidth)
					shapeLayer.path = UIBezierPath(rect: mostRecentSubview.bounds).cgPath
					shapeLayer.fillColor = nil
					shapeLayer.strokeColor = Color.black.CGColorView
					gradientLayer.mask = shapeLayer

					backgroundGradientLayers[mostRecentSubview] = gradientLayer
					mostRecentSubview.layer.insertSublayer(gradientLayer, at: 0)
				case .radial:
					precondition(false, "radial gradients not yet supported with UIViewRenderer")
				}
			}
		}
	}
}

extension UIBezierPath {
	internal convenience init(_ bezier: Bezier) {
		self.init()

		bezier.forEach { (segment) in
			switch segment {
			case let .move(to):
				move(to: to.CGPointView)
			case let .line(to):
				addLine(to: to.CGPointView)
			case let .arc(center, radius, start, end):
				addArc(withCenter: center.CGPointView, radius: CGFloat(radius), startAngle: CGFloat(start), endAngle: CGFloat(end), clockwise: true)
			case let .curve(point, controlPoint1, controlPoint2):
				addCurve(to: point.CGPointView, controlPoint1: controlPoint1.CGPointView, controlPoint2: controlPoint2.CGPointView)
			case let .quadCurve(point, controlPoint):
				addQuadCurve(to: point.CGPointView, controlPoint: controlPoint.CGPointView)
			case .close:
				close()
			}
		}
	}
}

internal extension Color {
	internal var UIColorView: UIColor {
		let hsb = HSBView
		return UIColor(hue: CGFloat(hsb.hue), saturation: CGFloat(hsb.saturation), brightness: CGFloat(hsb.brightness), alpha: CGFloat(AView))
	}
}
