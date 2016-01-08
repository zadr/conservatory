/**
Define a *Shape* type. A shape is a set of extensions on top of *Bezier*s to make them easier to work with.
*/
public typealias Shape = Bezier

/**
Define a *Shape* renderer. Because *Shape* is a set of extensions on top of *Bezier*s to make them easier to work with, a *Shape* renderer is a *Bezier* renderer.
*/
public typealias ShapeDrawer = BezierDrawer

/**
A renderer that knows how to draw beziers, and how to store it's appearance attributes until render-time.
*/
public struct BezierDrawer: AppearanceContainer, Viewable {
	public let shape: Shape

	public init(shape _shape: Shape) {
		shape = _shape
	}

	// MARK: - Appearance

	public var appearance = Appearance()

	// MARK: - Viewable

	/**
	Render a shape into the current canvas, in the following order:
	1. Apply the blend mode
	2. Apply the current transform
	3. Draw the shape
	4. Apply the background color(s)
	5. Apply the aura
	6. Apply the border color(s)
	*/
	public func render<T: Renderer>(renderer: T) {
		renderer.apply(appearance.blendMode)
		renderer.apply(appearance.transform)

		renderer.draw(shape)

		renderer.apply(appearance.aura)
		renderer.apply(appearance.border, width: appearance.borderWidth)
		renderer.stroke()

		renderer.apply(appearance.background)
		renderer.fill()
	}
}
