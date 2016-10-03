// todo: non-rectangular canvases

/**
A *Canvas* is the base object that everything is rendered onto.

*Canvas*es conform to the *AppearanceContainer* and *Viewable* protocols, and can be recursively drawn inside of one another.
*/
public final class Canvas<T: Renderer>: AppearanceContainer, Viewable {
	private let renderer: T
	private var viewables: [Viewable]

	/**
	Create a *Canvas*.
	- Parameter size: How big should the canvas be? If no size is given, the default canvas is 1024x768 pixels in size.
	*/
	public init(size: Size = Size(width: 1024.0, height: 768.0)) {
		renderer = T(size: size)
		viewables = [Viewable]()
	}

	/**
	How big is the canvas, in pixels.
	*/
	public var size: Size {
		return renderer.size
	}

	/**
	Add a *Viewable* object to be rendered onto the current canvas.
	*/
	public func add(_ viewable: Viewable) {
		viewables.append(viewable)
	}

	/**
	Add a list of *Viewable* objects to be rendered onto the current canvas.
	*/
	public func add(viewables _viewables: [Viewable]) {
		viewables += _viewables
	}

	public func debugQuickLookObject() -> AnyObject? {
		return currentRepresentation as AnyObject?
	}

	/**
	Render the current list of viewable objects, and return the results of said operation.
	*/
	public var currentRepresentation: T.RenderResultType? {
		return renderer.render([ self ])
	}

	// MARK: - Appearance

	public var appearance = Appearance()

	// MARK: - Viewable

	/**
	Render the current canvas, in the following order:
	1. Apply the blend mode
	2. Apply the current transform
	3. Apply the background color(s)
	4. Render any objects that have been added to the canvas
	5. Apply the aura
	6. Apply the border color(s)
	*/
	public func render<T: Renderer>(_ renderer: T) {
		renderer.apply(appearance.blendMode)
		renderer.apply(appearance.transform)
		renderer.apply(appearance.background)
		renderer.fill()

		let _ = renderer.render(viewables)

		renderer.apply(appearance.aura)
		renderer.apply(appearance.border, width: appearance.borderWidth)
		renderer.stroke()
	}
}
