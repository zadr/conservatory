import QuartzCore

public final class CARenderer: Renderer {
	public typealias RenderResultType = CALayer

	private let layer = CALayer()

	private var activeLayer: CALayer!
	private var activeLayerAppearance: Appearance!

	public init(size: Size) {
		layer.bounds = Box(size: size).CGRectView
	}

	public var size: Size {
		return Size(size: layer.bounds.size)
	}

	public func render(_ viewable: Viewable) -> RenderResultType? {
		return render([ viewable ])
	}

	public func render(_ viewables: [Viewable]) -> RenderResultType? {
		viewables.forEach {
			// reset state before each run
			activeLayerAppearance = Appearance()
			activeLayer = nil

			$0.render(self)

			guard let activeLayer = activeLayer, let activeLayerAppearance = activeLayerAppearance else {
				fatalError("activeLayer must be non-nil after render")
			}

			// aura
			if let aura = activeLayerAppearance.aura {
				activeLayer.shadowColor = aura.color.CGColorView
				activeLayer.shadowOpacity = Float(aura.color.AView)
				activeLayer.shadowOffset = aura.offset.CGSizeView
				activeLayer.shadowRadius = CGFloat(aura.blur)
			}

			// blend modes
			if var blendableLayer = activeLayer as? CVBlendableLayer {
				blendableLayer.blendMode = activeLayerAppearance.blendMode
			}

			// transform
			activeLayer.setAffineTransform(activeLayerAppearance.transform.CGAffineTransformView)

			layer.addSublayer(activeLayer)
		}

		layer.setNeedsDisplay()
		layer.displayIfNeeded()

		return layer
	}

	public func draw(_ bezier: Bezier) {
		let shapeLayer = CVShapeLayer()
		shapeLayer.path = bezier.CGPathView

		activeLayer = shapeLayer
	}

	public func draw(_ image: Image) {
		let imageLayer = CVLayer()
		imageLayer.bounds = Box(size: image.size).CGRectView
		imageLayer.contents = image.CGImageView

		activeLayer = imageLayer
	}

	public func draw(_ text: String, withTextEffects effects: [TextEffect]) {
		let textLayer = CVTextLayer()
		textLayer.allowsFontSubpixelQuantization = true
		textLayer.string = text.cocoaValue(effects)

		activeLayer = textLayer
	}

	public func apply(_ aura: Aura?) {
		activeLayerAppearance.aura = aura
	}

	public func apply(_ background: Palette<Color, GradientOptions>) {
		activeLayerAppearance.background = background
	}

	public func apply(_ border: Palette<Color, GradientOptions>, width: Double) {
		activeLayerAppearance.border = border
		activeLayerAppearance.borderWidth = width
	}

	public func apply(_ blendMode: BlendMode) {
		activeLayerAppearance.blendMode = blendMode
	}

	public func apply(_ transform: Transform) {
		activeLayerAppearance.transform = transform
	}

	public func fill() {
		switch activeLayerAppearance.background {
		case .none:
			activeLayer.backgroundColor = Color.transparent.CGColorView
		case .solid(let backgroundColor):
			activeLayer.backgroundColor = backgroundColor.CGColorView
		case .gradient(let backgroundColors, let options):
			switch options.type {
			case .linear:
				var start = CGPoint(x: layer.bounds.midX, y: layer.bounds.minY)
				start = start.applying(CGAffineTransform(rotationAngle: CGFloat(options.rotation)))

				var end = CGPoint(x: layer.bounds.midX, y: layer.bounds.maxY)
				end = end.applying(CGAffineTransform(rotationAngle: CGFloat(options.rotation)))

				let gradientLayer = CAGradientLayer()
				gradientLayer.bounds = activeLayer.bounds
				gradientLayer.colors = backgroundColors.map { return $0.CGColorView }
				gradientLayer.locations = backgroundColors.positions.map { return NSNumber(value: $0) }
				gradientLayer.startPoint = start
				gradientLayer.endPoint = end

				activeLayer.addSublayer(gradientLayer)
			case .radial:
				precondition(false, "radial gradients not yet supported with CARenderer")
			}
		}
	}

	public func stroke() {
		// border
		switch activeLayerAppearance.border {
		case .none:
			activeLayer.borderColor = nil
			activeLayer.borderWidth = 0.0
		case .solid(let borderColor):
			activeLayer.borderColor = borderColor.CGColorView
			activeLayer.borderWidth = CGFloat(activeLayerAppearance.borderWidth)
		case .gradient(_, _):
			precondition(false, "border gradients not yet supported with CARenderer")
		}
	}
}

// MARK: -

private protocol CVBlendableLayer {
	var blendMode: BlendMode { set get }
}

private final class CVLayer: CALayer {
	var blendMode: BlendMode = .normal

	override func draw(in ctx: CGContext) {
		ctx.setBlendMode(blendMode.CGBlendView)

		super.draw(in: ctx)
	}
}

private final class CVTextLayer: CATextLayer {
	var blendMode: BlendMode = .normal

	override func draw(in ctx: CGContext) {
		ctx.setBlendMode(blendMode.CGBlendView)

		super.draw(in: ctx)
	}
}

private final class CVShapeLayer: CAShapeLayer {
	var blendMode: BlendMode = .normal

	override func draw(in ctx: CGContext) {
		ctx.setBlendMode(blendMode.CGBlendView)

		super.draw(in: ctx)
	}
}
