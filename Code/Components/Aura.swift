/**
An aura describes the outer effects of an input, for example, a shadow or an outer glow.
*/
public struct Aura {
	internal let color: Color // todo: gradientized. (CG impl: render into a patterned image)
	internal let offset: Size
	internal let blur: Double

	/**
	Create an *Aura*

	- Parameter color: The default color is **transparent**.
	- Parameter offset: The default offset is **Size.zero**.
	- Parameter blur: The default blur is **0**.
	*/
	public init(color _color: Color = Color.transparent, offset _offset: Size = Size.zero, blur _blur: Double = 0.0) {
		color = _color
		offset = _offset
		blur = _blur
	}

	/**
	Private: Determines whether an aura is visible or not.

	- Returns: **true** or **false**.
	*/
	internal var shouldApplyAura: Bool {
		get {
			return color.AView > 0.0
		}
	}

	/**
	A light glow is defined as a *white color with 1/3 alpha*, a blur of *3* and a light source position of *{0, 2}*.

	- Returns: An *Aura* that can be applied to an input.
	*/
	public static var lightGlow: Aura {
		get {
			return Aura(color: Color.white.withAlpha(float: 1.0 / 3.0), offset: Size(width: 0.0, height: 2.0), blur: 3.0)
		}
	}

	/**
	A dark shadow is defined as a *black color with 1/3 alpha*, a blur of *3* and a light source position of *{0, 0}*.

	- Returns: An *Aura* that can be applied to an input.
	*/
	public static var darkShadow: Aura {
		get {
			return Aura(color: Color.black.withAlpha(float: 1.0 / 3.0), offset: Size.zero, blur: 3.0)
		}
	}
}

extension Aura: CustomStringConvertible {
	public var description: String {
		get {
			return "Aura(color: \(color), offset: \(offset), blur: \(blur))"
		}
	}
}

extension Aura: Hashable {
	public var hashValue: Int {
		get {
			// todo: figure out how to use offset's hash without passing in `.hashValue` directly
			// (it works if `Point` is a class, but not a struct)
			return [ color, offset.hashValue, blur ].hashValue
		}
	}
}

/**
An *Aura* is considered equal to another *Aura* if it has identical *color*s, *offset*s, and *blur*s.
*/
public func ==(x: Aura, y: Aura) -> Bool {
	return x.color == y.color && x.offset == y.offset && x.blur == y.blur
}
