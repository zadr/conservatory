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

/**
A renderer that knows how to draw an image, and how to store it's appearance attributes until render-time.
*/
public struct ImageDrawer: AppearanceContainer, Viewable {
	public let image: Image

	/**
	Create an image renderer that can draw a bitmapped image in a renderer.
	Parameter image: A bitmap representation of an image.
	*/
	public init(image _image: Image) {
		image = _image
	}

	// MARK: - Appearance

	public var appearance = Appearance()

	// MARK: - Viewable

	/**
	Render an image into the current canvas, in the following order:
	1. Render our image.
	2. Apply the aura
	3. Apply the blend mode
	4. Apply the current transform
	5. Apply our background color(s).
	6. Apply our border color(s).
	*/
	public func render<T: Renderer>(_ renderer: T) {
		renderer.draw(image)

		renderer.apply(appearance.aura)
		renderer.apply(appearance.blendMode)
		renderer.apply(appearance.transform)

		renderer.apply(appearance.background)
		renderer.fill()

		renderer.apply(appearance.border, width: appearance.borderWidth)
		renderer.stroke()
	}
}
