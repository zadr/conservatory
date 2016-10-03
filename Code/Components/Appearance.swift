/**
An object that holds appearance state for a *Viewable* item.
*/
public struct Appearance {
	/**
	The effects that apply outside of the input, for example, an outer glow or a shadow.

	This has a default value of **nil**.
	*/
	public var aura: Aura?

	/**
	The background color of an input to be drawn. By default, this is **.None**, which is results in a transparent background.

	This has a default value of **Palette.None**.
	*/
	public var background: Palette<Color, GradientOptions> = .none

	/**
	The border color of an input to be drawn. By default, this is **.None**, which is results in a transparent border.

	This has a default value of **Palette.None**.
	*/
	public var border: Palette<Color, GradientOptions> = .none

	/**
	The width of a border to draw.

	This has a default value of **0**.
	*/
	public var borderWidth: Double = 0

	/**
	The blend mode draw with. By default, this is *.Normal*, or, no blending.

	This has a default value of **.Normal**.
	*/
	public var blendMode: BlendMode = .normal

	/**
	The top-left coordinate of where an input should appear in a canvas?.

	This has a default value of **Point.zero**.
	*/
	public var position: Point = Point.zero

	/**
	The transform to apply to the drawing, e.g.: for a rotation, skew or scale. By default, this is *Transform.identity*, or, no adjustments.

	This has a default value of **Transform.identity**.
	*/
	public var transform: Transform = Transform.identity
}

/**
A protocol that provides the interface for an object to have its appearance described in a way that a *Renderer* will understand.
*/
public protocol AppearanceContainer {
	var appearance: Appearance { get }
}
