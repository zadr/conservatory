/**
A protocol that defines the interface that all renderers in Cotton Duck support drawing onto. This protocol seeks to define the interface for a renderer, without defining any implementation details.
*/
public protocol Renderer {
	/**
	What kind of struct or class will the renderer generate?
	*/
	associatedtype RenderResultType

	/**
	Initialize a renderer with a canvas *Size*. It is up to the renderer to decide if content may be drawn outside of its bounding box.
	*/
	init(size: Size)

	/**
	- Returns: The visible *Size* of the target that a renderer is rendering its contents onto.
	*/
	var size: Size { get }

	/**
	Render a single *Viewable* object and return the results of the render.

	- Parameter viewable: A single object that confroms to the *Viewable* protocol.
	*/
	func render(_ viewable: Viewable) -> RenderResultType?

	/**
	Render a list of *Viewable* objects and return the results of the render.

	- Parameter viewable: A list of objects that confroms to the *Viewable* protocol.
	*/
	func render(_ viewables: [Viewable]) -> RenderResultType?

	/**
	Prepare the *Renderer* to draw a *Bezier*.

	- Parameter bezier: A *Bezier* that contains one or more lines.
	*/
	func draw(_ bezier: Bezier)

	/**
	Prepare the *Renderer* to draw an *Image*.

	- Parameter image: A decompressed *Image* that contains bitmap data.
	*/
	func draw(_ image: Image)

	/**
	Prepare the *Renderer* to draw text with a list of attributes to apply to the text.

	- Parameter text: a UTF-8-compatible string to draw.
	- Parameter effects: A list of *TextEffect* that describe attributes to apply to ranges of text being drawn.
	*/
	func draw(_ text: String, withTextEffects effects: [TextEffect])

	/**
	Set the aura for the next drawing operation.

	- Parameter aura: The outer effects. If nil is passed in, any aura is removed.
	*/
	func apply(_ aura: Aura?)

	/**
	Set the background color for the next drawing operation to a single color.

	- Parameter border: The background color palette to use.
	*/
	func apply(_ background: Palette<Color, GradientOptions>)

	/**
	Set the outline colors for the next drawing operation to a gradient.

	- Parameter border: The border color palette to use.
	- Parameter width: How wide should the border be?
	*/
	func apply(_ border: Palette<Color, GradientOptions>, width: Double)

	/**
	Set the blend mode for the next drawing operation.
	*/
	func apply(_ blendMode: BlendMode)

	/**
	Set the transform for the next drawing operation. See [here](https://en.wikipedia.org/wiki/Affine_transformation) for discussions on affine transforms. The default *Transform* is *Identity*.
	*/
	func apply(_ transform: Transform)

	/**
	Fill in the background of the renderer's current drawing.
	*/
	func fill()

	/**
	Fill in the border of the renderer's current drawing.
	*/
	func stroke()
}

/**
A *Palette* is an *Either* type that either has *zero* in it, which results in a transparent color, *one* color in it for a solid color, or an *infinite* number of colors for a gradient.
*/
public enum Palette<T, U> {
	case none
	case solid(T)
	case gradient([T], U)
}

/**
A protocol that provides the interface for an input to be drawn onto a *Renderer*.
*/
public protocol Viewable {
	/**
	The entrypoint for an input to be rendered. An input may in turn call *render<T>()* on any children that it contains, to allow for nested items.
	*/
	func render<T: Renderer>(_ renderer: T)
}

// MARK: -

/**
What kinds of gradients can we draw inputs with?
*/
public enum GradientType {
	case linear
	case radial
}

public struct GradientOptions {
	internal let beforeScene: Bool
	internal let afterScene: Bool
	internal let type: GradientType
	internal let rotation: Degree

	public init(beforeScene _beforeScene: Bool = true, afterScene _afterScene: Bool = true,
				type _type: GradientType = .linear, rotation _rotation: Degree = 0.0) {
		beforeScene = _beforeScene
		afterScene = _afterScene
		type = _type
		rotation = _rotation
	}
}
