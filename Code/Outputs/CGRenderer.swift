import CoreGraphics
import CoreText

// MARK: -

/**
A renderer that can take in inputs and output a CGImageRef.
*/
public final class CGRenderer: Renderer {
	public typealias RenderResultType = CGImageRef

	private let bitmapContext: CGContextRef
	private var bezier: Bezier?
	private var backgroundColors: Gradient?
	private var borderColors: Gradient?

	public let size: Size
	public init(size _size: Size = Size(width: 1024.0, height: 768.0)) {
		setenv("CGBITMAP_CONTEXT_LOG_ERRORS", "1", 1)
		setenv("CG_CONTEXT_SHOW_BACKTRACE", "1", 1)

		size = _size

		bitmapContext = CGBitmapContextCreate(nil, Int(size.width), Int(size.height), 8, 32 * Int(size.width), CGColorSpaceCreateDeviceRGB(), CGImageAlphaInfo.PremultipliedLast.rawValue)!
		CGContextTranslateCTM(bitmapContext, 0.0, CGFloat(size.height))
		CGContextScaleCTM(bitmapContext, 1.0, -1.0)
	}

	public func render(viewable: Viewable) -> RenderResultType? {
		return render([ viewable ])
	}

	public func render(viewables: [Viewable]) -> RenderResultType? {
		viewables.forEach({
			// reset state before each run
			CGContextSaveGState(bitmapContext); defer { CGContextRestoreGState(bitmapContext) }
			bezier = nil

			$0.render(self)
		})

		bezier = nil

		return CGBitmapContextCreateImage(bitmapContext)
	}

	private var antialias = true {
		didSet {
			CGContextSetAllowsAntialiasing(bitmapContext, antialias)
			CGContextSetShouldAntialias(bitmapContext, antialias)
		}
	}

	private var encompassingRect: CGRect {
		get {
			return Box(size: size).CGRectView
		}
	}

	// todo: investigate swift and figure out when this signature can be draw(bezier _bezier: BezierType) without conflicting with draw(image: ImageType)
	public func draw(bezier: Bezier) {
		// due to how CoreGraphics works, the bezier has to be added to the context before each call to fill() and stroke()
		// todo?: investigate if we should we use CGContextSaveGState() before fill() and stroke() instead of keeping this around as a local property
		self.bezier = bezier
	}

	public func draw(image: Image) {
		let rect = CGRectMake(0.0, 0.0, CGFloat(image.size.width), CGFloat(image.size.height))
		CGContextDrawImage(bitmapContext, rect, image.CGImage)
	}

	public func draw(text: String, withTextEffects effects: [TextEffect]) {
		let attributedString = text.cocoaValue(effects)

		CGContextSaveGState(bitmapContext); defer { CGContextRestoreGState(bitmapContext) }

		CGContextTranslateCTM(bitmapContext, 0.0, CGFloat(size.height))
		CGContextScaleCTM(bitmapContext, 1.0, -1.0)

		let framesetter = CTFramesetterCreateWithAttributedString(attributedString)
		let path = CGPathCreateMutable()
		CGPathAddRect(path, nil, encompassingRect)

		let frame = CTFramesetterCreateFrame(framesetter, CFRange(location: 0, length: text.utf8.count), path, nil)
		CTFrameDraw(frame, bitmapContext)
	}

	public func apply(aura: Aura?) {
		if let aura = aura {
			CGContextSetShadowWithColor(bitmapContext, aura.offset.CGSizeView, CGFloat(aura.blur), aura.color.CGColorView)
		} else {
			CGContextSetShadowWithColor(bitmapContext, Size.zero.CGSizeView, 0.0, nil)
		}
	}

	public func apply(blendMode: BlendMode) {
		CGContextSetBlendMode(bitmapContext, blendMode.CGBlendView)
	}

	public func apply(background: Palette<Color, GradientOptions>) {
		switch background {
		case .None:
			CGContextSetFillColorWithColor(bitmapContext, nil)
		case .Solid(let backgroundColor):
			CGContextSetFillColorWithColor(bitmapContext, backgroundColor.CGColorView)
		case .Gradient(let backgroundColors, let options):
			self.backgroundColors = Gradient(colors: backgroundColors, options: options)
		}
	}

	public func apply(border: Palette<Color, GradientOptions>, width: Double) {
		switch border {
		case .None:
			CGContextSetFillColorWithColor(bitmapContext, nil)
		case .Solid(let borderColor):
			CGContextSetStrokeColorWithColor(bitmapContext, borderColor.CGColorView)
		case .Gradient(let borderColors, let options):
			self.borderColors = Gradient(colors: borderColors, options: options)
		}

		CGContextSetLineWidth(bitmapContext, CGFloat(width))
	}

	public func apply(transform: Transform) {
		CGContextConcatCTM(bitmapContext, transform.CGAffineTransformView)
	}

	private func draw(colors: [Color], positions: [Double], options: GradientOptions, bounds: CGRect) {
		let gradientOptions = options.CGGradientDrawingOptionsView

		let CGColors = colors.map({ return $0.CGColorView })
		let CGPositions = positions.map({ return CGFloat($0) })
		let gradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), CGColors, CGPositions)

		switch options.type {
		case .Linear:
			var start = CGPoint(x: CGRectGetMidX(bounds), y: CGRectGetMinY(bounds))
			start = CGPointApplyAffineTransform(start, CGAffineTransformMakeRotation(CGFloat(options.rotation)))

			var end = CGPoint(x: CGRectGetMidX(bounds), y: CGRectGetMaxY(bounds))
			end = CGPointApplyAffineTransform(end, CGAffineTransformMakeRotation(CGFloat(options.rotation)))

			CGContextDrawLinearGradient(bitmapContext, gradient, start, end, gradientOptions)
		case .Radial:
			let start = CGPoint(x: CGRectGetMidX(bounds), y: CGRectGetMidY(bounds))
			let end = CGPoint(x: CGRectGetMidX(bounds), y: CGRectGetMidY(bounds))

			CGContextDrawRadialGradient(bitmapContext, gradient, start, 0.0, end, CGRectGetMidX(bounds), gradientOptions)
		}
	}

	private func apply(mode: CGPathDrawingMode, gradient: Gradient?) {
		CGContextSaveGState(bitmapContext)

		let rect: CGRect
		if let bezier = bezier {
			rect = CGPathGetBoundingBox(bezier.CGPathView)
			CGContextAddPath(bitmapContext, bezier.CGPathView)
		} else {
			rect = encompassingRect
			CGContextAddRect(bitmapContext, encompassingRect)
		}

		if let gradient = gradient {
			CGContextClip(bitmapContext)

			draw(gradient.colors, positions: gradient.colors.positions, options: gradient.options, bounds: rect)
		} else {
			CGContextDrawPath(bitmapContext, mode)
		}

		CGContextRestoreGState(bitmapContext)
	}

	public func fill() {
		apply(.Fill, gradient: backgroundColors)
		backgroundColors = nil
	}

	public func stroke() {
		apply(.Stroke, gradient: borderColors)
		borderColors = nil
	}
}

private struct Gradient {
	let colors: [Color]
	let options: GradientOptions
}
