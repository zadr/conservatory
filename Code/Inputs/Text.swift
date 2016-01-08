// todo?: init(text: String markdown: Bool = false) (which flavor of markdown?)

/**
A renderer that knows how to draw text, and how to store it's appearance attributes until render-time.
*/
public struct TextDrawer: AppearanceContainer, Viewable {
	public let text: String
	private var effects: Set<TextEffect>

	public init(text _text: String) {
		text = _text
		effects = Set<TextEffect>([])
	}

	// MARK: - Text

	public mutating func add(effect: TextEffect) {
		add([effect])
	}

	public mutating func add(newTextEffects: [TextEffect]) {
		effects.unionInPlace(Set(newTextEffects))
	}

	public mutating func remove(effect: TextEffect) {
		remove([effect])
	}

	public mutating func remove(oldTextEffects: [TextEffect]) {
		effects.subtractInPlace(Set(oldTextEffects))
	}

	public mutating func removeAllEffects() {
		effects.removeAll()
	}

	// MARK: - Appearance

	public var appearance = Appearance()

	// MARK: - Viewable

	/**
	Render text into current canvas, in the following order:
	1. Apply the aura
	2. Apply the blend mode
	3. Apply the current transform
	4. Apply the background color(s)
	5. Apply the border color(s)
	6. Draw the text (and any effects)
	*/
	public func render<T: Renderer>(renderer: T) {
		renderer.apply(appearance.aura)
		renderer.apply(appearance.blendMode)
		renderer.apply(appearance.transform)
		renderer.apply(appearance.background)
		renderer.apply(appearance.border, width: appearance.borderWidth)

		renderer.draw(text, withTextEffects: Array(effects))
	}
}

// MARK: -

public struct Font {
	internal let name: String
	internal let size: Double

	public init(name _name: String = "Helvetica", size _size: Double = 18.0) {
		name = _name
		size = _size
	}
}

extension Font: Hashable {
	public var hashValue: Int {
		get {
			return [ name, size ].hashValue
		}
	}
}

public func ==(x: Font, y: Font) -> Bool {
	return x.name == y.name && x.size == y.size
}

// MARK: -

public enum LinePattern {
	case None
	case Single
	case Thick
	case Double
	case Dotted
	case Dashed
	case DashedAndDotted
	case DashedAndDottedTwice
}

// todo: underline color, strikethrough, auras
public struct TextEffect: Hashable {
	internal let bold: Bool
	internal let italic: Bool
	internal let underline: LinePattern
//	internal let strikethrough: LinePattern
	internal let font: Font
	internal let kerning: Double
	internal let ligature: Int
//	internal let aura: Aura
	internal let metadata: [String: AnyObject]
	internal let range: Range<String.Index>

	public init(bold _bold: Bool = false, italic _italic: Bool = false,
				underline _underline: LinePattern = .None, /* strikethrough _strikethrough: LinePattern = .None, */
				font _font: Font = Font(name: "Optima", size: 18.0), kerning _kerning: Double = 0.0, ligature _ligature: Bool = true,
				/* aura _aura: Aura = Aura(), */ metadata _metadata: [String: AnyObject] = [String: AnyObject](),
				range _range: Range<String.Index>) {
		bold = _bold
		italic = _italic
		underline = _underline
//		strikethrough = _strikethrough
		font = _font
//		aura = _aura
		kerning = _kerning
		ligature = _ligature ? 1 : 0
		metadata = _metadata
		range = _range
	}

	public var hashValue: Int {
		get {
			return [ bold, italic, underline.hashValue, /* strikethrough.hashValue, */ font.hashValue, /* aura.hashValue, */ kerning, ligature, range.hashValue ].hashValue
		}
	}
}

public func ==(x: TextEffect, y: TextEffect) -> Bool {
	return x.bold == y.bold && x.italic == y.italic && x.underline == y.underline &&
		  /* x.strikethrough == y.strikethrough && */ x.font == y.font && /* x.aura == y.aura && &*/
		  x.kerning == y.kerning && x.range == y.range
}

// MARK: -

extension Range: Hashable {
	public var hashValue: Int {
		get {
			return description.hashValue
		}
	}
}
