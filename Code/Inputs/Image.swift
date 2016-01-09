/**
The native Image type in Cotton Duck.
*/

/**
A protocol that images can conform to in order to proclaim their output can be saved into image formats.
*/
public protocol ImageViewable {
	var bitmapView: UnsafePointer<UInt8> { get }
	var JPEGView: UnsafePointer<UInt8> { get }
	var PNGView: UnsafePointer<UInt8> { get }
}

// todo: it would be nice for `Image` to be a protocol implemented by things (eg: `BitmapImage`, `VectorImage`, etc)
// todo: it would be nice to support more than `RGBA` pixel ordering
public struct Image {
	internal let storage: UnsafePointer<UInt8>
	public let size: Size

	/**
	Create an *Image* of a certain *Size* with raw RGBA data.
	*/
	public init(data: UnsafePointer<UInt8>, size _size: Size) {
		storage = data
		size = _size
	}

	public init(image: ImageViewable, size _size: Size) {
		self.init(data: image.bitmapView, size: _size)
	}
}

// MARK: -

// todo: figure out how to make `ImageEffect` more generic so it can apply to Canvas' and Movie's (ideally, without recreating the same logic)
public struct ImageEffect {
	internal let overlaysBackgroundColor: Bool

	public init(overlaysBackgroundColor _overlaysBackgroundColor: Bool = false) {
		overlaysBackgroundColor = _overlaysBackgroundColor
	}
}

/**
A renderer that knows how to draw an image, and how to store it's appearance attributes until render-time.
*/
public struct ImageDrawer: AppearanceContainer, Viewable {
	public let image: Image
	private var options: ImageEffect

	/**
	Create an image renderer that can draw a bitmapped image in a renderer.
	Parameter image: A bitmap representation of an image.
	Parameter options: An optional set of options that help determine how an image is rendered. May not be nil, but, may be omitted.
	*/
	public init(image _image: Image, options _options: ImageEffect = ImageEffect()) {
		image = _image
		options = _options
	}

	// MARK: - Appearance

	public var appearance = Appearance()

	// MARK: - Viewable

	/**
	Render an image into the current canvas, in the following order:
	1. Apply the aura
	2. Apply the blend mode
	3. Apply the current transform
	4. Check to see if our image options call for drawing the background first. If so, apply our background color(s).
	5. Render our image.
	6. Check to see if our image options call for drawing the background on top of our image. If so, apply our background color(s).
	*/
	public func render<T: Renderer>(renderer: T) {
		renderer.apply(appearance.aura)
		renderer.apply(appearance.blendMode)
		renderer.apply(appearance.transform)

		let fill = {
			renderer.apply(self.appearance.background)
			renderer.fill()
		}

		if !options.overlaysBackgroundColor {
			fill()
		}

		renderer.draw(image)

		if options.overlaysBackgroundColor {
			fill()
		}

		renderer.apply(appearance.border, width: appearance.borderWidth)
		renderer.stroke()
	}
}
