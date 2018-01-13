import CoreGraphics
import CoreText

// MARK: -

/**
A renderer that can take in inputs and output a CGImageRef.
*/
public final class CGRenderer: Renderer {
	public typealias RenderResultType = CGImage

	private let bitmapContext: CGContext
	private var bezier: Bezier?
	private var backgroundColors: Gradient?
	private var borderColors: Gradient?

	public let size: Size
	public init(size _size: Size = Size(width: 1024.0, height: 768.0)) {
		setenv("CGBITMAP_CONTEXT_LOG_ERRORS", "1", 1)
		setenv("CG_CONTEXT_SHOW_BACKTRACE", "1", 1)

		size = _size

		bitmapContext = CGContext(data: nil, width: Int(size.width), height: Int(size.height), bitsPerComponent: 8, bytesPerRow: 32 * Int(size.width), space: CGColorSpaceCreateDeviceRGB(), bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
		bitmapContext.translateBy(x: 0.0, y: CGFloat(size.height))
		bitmapContext.scaleBy(x: 1.0, y: -1.0)
	}

	public func render(_ viewable: Viewable) -> RenderResultType? {
		return render([ viewable ])
	}

	public func render(_ viewables: [Viewable]) -> RenderResultType? {
		viewables.forEach {
			// reset state before each run
			bitmapContext.saveGState(); defer { bitmapContext.restoreGState() }
			bezier = nil

			$0.render(self)
		}

		bezier = nil

		return bitmapContext.makeImage()
	}

	private var antialias = true {
		didSet {
			bitmapContext.setAllowsAntialiasing(antialias)
			bitmapContext.setShouldAntialias(antialias)
		}
	}

	private var encompassingRect: CGRect {
		return Box(size: size).CGRectView
	}

	public func draw(_ bezier: Bezier) {
		// due to how CoreGraphics works, the bezier has to be added to the context before each call to fill() and stroke()
		// todo?: investigate if we should we use CGContextSaveGState() before fill() and stroke() instead of keeping this around as a local property
		self.bezier = bezier
	}

	public func draw(_ image: Image) {
		let rect = CGRect(x: 0.0, y: 0.0, width: CGFloat(image.size.width), height: CGFloat(image.size.height))
		bitmapContext.draw(image.CGImageView, in: rect)
	}

	public func draw(_ text: String, withTextEffects effects: [TextEffect]) {
		let attributedString = text.cocoaValue(effects)

		bitmapContext.saveGState(); defer { bitmapContext.restoreGState() }

		bitmapContext.translateBy(x: 0.0, y: CGFloat(size.height))
		bitmapContext.scaleBy(x: 1.0, y: -1.0)

		let framesetter = CTFramesetterCreateWithAttributedString(attributedString)
		let path = CGMutablePath()
		path.addRect(encompassingRect)

		let frame = CTFramesetterCreateFrame(framesetter, CFRange(location: 0, length: text.utf8.count), path, nil)
		CTFrameDraw(frame, bitmapContext)
	}

	public func apply(_ aura: Aura?) {
		if let aura = aura {
			bitmapContext.setShadow(offset: aura.offset.CGSizeView, blur: CGFloat(aura.blur), color: aura.color.CGColorView)
		} else {
			bitmapContext.setShadow(offset: Size.zero.CGSizeView, blur: 0.0, color: nil)
		}
	}

	public func apply(_ blendMode: BlendMode) {
		bitmapContext.setBlendMode(blendMode.CGBlendView)
	}

	public func apply(_ background: Palette<Color, GradientOptions>) {
		switch background {
		case .none:
			bitmapContext.setFillColor(Color.clear.CGColorView)
		case .solid(let backgroundColor):
			bitmapContext.setFillColor(backgroundColor.CGColorView)
		case .gradient(let backgroundColors, let options):
			self.backgroundColors = Gradient(colors: backgroundColors, options: options)
		}
	}

	public func apply(_ border: Palette<Color, GradientOptions>, width: Double) {
		switch border {
		case .none:
			bitmapContext.setFillColor(Color.clear.CGColorView)
		case .solid(let borderColor):
			bitmapContext.setStrokeColor(borderColor.CGColorView)
		case .gradient(let borderColors, let options):
			self.borderColors = Gradient(colors: borderColors, options: options)
		}

		bitmapContext.setLineWidth(CGFloat(width))
	}

	public func apply(_ transform: Transform) {
		bitmapContext.concatenate(transform.CGAffineTransformView)
	}

	private func draw(_ colors: [Color], positions: [Double], options: GradientOptions, bounds: CGRect) {
		let gradientOptions = options.CGGradientDrawingOptionsView

		let CGColors = colors.map { return $0.CGColorView } as CFArray
		let CGPositions = positions.map { return CGFloat($0) }
		let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: CGColors, locations: CGPositions)

		switch options.type {
		case .linear:
			var start = CGPoint(x: bounds.midX, y: bounds.minY)
			start = start.applying(CGAffineTransform(rotationAngle: CGFloat(options.rotation)))

			var end = CGPoint(x: bounds.midX, y: bounds.maxY)
			end = end.applying(CGAffineTransform(rotationAngle: CGFloat(options.rotation)))

			bitmapContext.drawLinearGradient(gradient!, start: start, end: end, options: gradientOptions)
		case .radial:
			let start = CGPoint(x: bounds.midX, y: bounds.midY)
			let end = CGPoint(x: bounds.midX, y: bounds.midY)

			bitmapContext.drawRadialGradient(gradient!, startCenter: start, startRadius: 0.0, endCenter: end, endRadius: bounds.midX, options: gradientOptions)
		}
	}

	private func apply(_ mode: CGPathDrawingMode, gradient: Gradient?) {
		bitmapContext.saveGState()

		let rect: CGRect
		if let bezier = bezier {
			rect = bezier.CGPathView.boundingBox
			bitmapContext.addPath(bezier.CGPathView)
		} else {
			rect = encompassingRect
			bitmapContext.addRect(encompassingRect)
		}

		if let gradient = gradient {
			bitmapContext.clip()

			draw(gradient.colors, positions: gradient.colors.positions, options: gradient.options, bounds: rect)
		} else {
			bitmapContext.drawPath(using: mode)
		}

		bitmapContext.restoreGState()
	}

	public func fill() {
		apply(.fill, gradient: backgroundColors)
		backgroundColors = nil
	}

	public func stroke() {
		apply(.stroke, gradient: borderColors)
		borderColors = nil
	}
}

private struct Gradient {
	let colors: [Color]
	let options: GradientOptions
}
