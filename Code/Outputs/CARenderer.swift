import QuartzCore

public final class CARenderer: Renderer {
	public typealias RenderResultType = CALayer

	private let layer = CALayer()

	private var activeLayer: CALayer?
	private var activeLayerAppearance: Appearance?

	public init(size: Size) {
		layer.bounds = Box(size: size).CGRectView
	}

	public var size: Size {
		get {
			return Size(size: layer.bounds.size)
		}
	}

	public func render(viewable: Viewable) -> RenderResultType? {
		return render([ viewable ])
	}

	public func render(viewables: [Viewable]) -> RenderResultType? {
		viewables.forEach({
			// reset state before each run
			activeLayerAppearance = Appearance()
			activeLayer = nil

			$0.render(self)

			guard let activeLayer = activeLayer, activeLayerAppearance = activeLayerAppearance else {
				fatalError("activeLayer must be non-nil after render")
			}

			// aura
			if let aura = activeLayerAppearance.aura {
				activeLayer.shadowColor = aura.color.CGColorView
				activeLayer.shadowOpacity = Float(aura.color.AView)
				activeLayer.shadowOffset = aura.offset.CGSizeView
				activeLayer.shadowRadius = CGFloat(aura.blur)
			}

			// background
			switch activeLayerAppearance.background {
			case .None:
				activeLayer.backgroundColor = Color.transparent.CGColorView
			case .Solid(let backgroundColor):
				activeLayer.backgroundColor = backgroundColor.CGColorView
			case .Gradient(let backgroundColors, let options):
				switch options.type {
				case .Linear:
					var start = CGPoint(x: CGRectGetMidX(layer.bounds), y: CGRectGetMinY(layer.bounds))
					start = CGPointApplyAffineTransform(start, CGAffineTransformMakeRotation(CGFloat(options.rotation)))

					var end = CGPoint(x: CGRectGetMidX(layer.bounds), y: CGRectGetMaxY(layer.bounds))
					end = CGPointApplyAffineTransform(end, CGAffineTransformMakeRotation(CGFloat(options.rotation)))

					let gradientLayer = CAGradientLayer()
					gradientLayer.bounds = activeLayer.bounds
					gradientLayer.colors = backgroundColors.map({ return $0.CGColorView })
					gradientLayer.locations = backgroundColors.positions
					gradientLayer.startPoint = start
					gradientLayer.endPoint = end

					activeLayer.addSublayer(gradientLayer)
				case .Radial:
					precondition(false, "radial gradients not yet supported with CARenderer")
				}
			}

			// border
			switch activeLayerAppearance.border {
			case .None:
				activeLayer.borderColor = nil
				activeLayer.borderWidth = 0.0
			case .Solid(let borderColor):
				activeLayer.borderColor = borderColor.CGColorView
				activeLayer.borderWidth = CGFloat(activeLayerAppearance.borderWidth)
			case .Gradient(_, _):
				precondition(false, "border gradients not yet supported with CARenderer")
			}

			// blend modes
			if var blendableLayer = activeLayer as? CVBlendableLayer {
				blendableLayer.blendMode = activeLayerAppearance.blendMode
			}

			// transform
			activeLayer.setAffineTransform(activeLayerAppearance.transform.CGAffineTransformView)

			layer.addSublayer(activeLayer)
		})

		return layer
	}

	public func draw(bezier: Bezier) {
		let shapeLayer = CVShapeLayer()
		shapeLayer.path = bezier.CGPathView

		activeLayer = shapeLayer
	}

	public func draw(image: Image) {
		let imageLayer = CVLayer()
		imageLayer.bounds = Box(size: image.size).CGRectView
		imageLayer.contents = image.CGImage

		activeLayer = imageLayer
	}

	public func draw(text: String, withTextEffects effects: [TextEffect]) {
		let textLayer = CVTextLayer()
		textLayer.allowsFontSubpixelQuantization = true
		textLayer.string = text.cocoaValue(effects)

		activeLayer = textLayer
	}

	public func apply(aura: Aura?) {
		activeLayerAppearance!.aura = aura
	}

	public func apply(background: Palette<Color, GradientOptions>) {
		activeLayerAppearance!.background = background
	}

	public func apply(border: Palette<Color, GradientOptions>, width: Double) {
		activeLayerAppearance!.border = border
		activeLayerAppearance!.borderWidth = width
	}

	public func apply(blendMode: BlendMode) {
		activeLayerAppearance!.blendMode = blendMode
	}

	public func apply(transform: Transform) {
		activeLayerAppearance!.transform = transform
	}

	public func fill() { /* noop */ }

	public func stroke() { /* noop */ }
}

// MARK: -

private protocol CVBlendableLayer {
	var blendMode: BlendMode { set get }
}

private final class CVLayer: CALayer {
	var blendMode: BlendMode = .Normal

	override func drawInContext(ctx: CGContext) {
		CGContextSetBlendMode(ctx, blendMode.CGBlendView)

		super.drawInContext(ctx)
	}
}

private final class CVTextLayer: CATextLayer {
	var blendMode: BlendMode = .Normal

	override func drawInContext(ctx: CGContext) {
		CGContextSetBlendMode(ctx, blendMode.CGBlendView)

		super.drawInContext(ctx)
	}
}

private final class CVShapeLayer: CAShapeLayer {
	var blendMode: BlendMode = .Normal

	override func drawInContext(ctx: CGContext) {
		CGContextSetBlendMode(ctx, blendMode.CGBlendView)

		super.drawInContext(ctx)
	}
}
