/**
A renderer that can take in inputs and output a string literal description of the rendering process.
*/
public final class StringRenderer: Renderer {
	public typealias RenderResultType = String

	public typealias ImageType = String

	private var stringContext: String = ""
	private var level: Int = 0

	public let size: Size
	public init(size _size: Size = Size(width: 1024.0, height: 768.0)) {
		size = _size

		stringContext = ""
	}

	public func render(viewable: Viewable) -> RenderResultType? {
		return render([ viewable ])
	}

	public func render(viewables: [Viewable]) -> RenderResultType? {
		level += 1; defer { level -= 1 }

		viewables.forEach({
			if level > 0 {
				append("// \(String($0.dynamicType))")
			}

			$0.render(self)
		})

		return stringContext
	}

	private func append(string: String) {
		let tabs = String(count: level, repeatedValue: Character("\t"))
		stringContext += tabs + string + "\n"
	}

	public func draw(bezier: Bezier) {
		append("draw(bezier: \(bezier))")
	}

	public func draw(image: Image) {
		append("draw(image: \(image))")
	}

	public func draw(text: String, withTextEffects effects: [TextEffect]) {
		append("draw(text: \(text), withTextEffects: \(effects)")
	}

	public func apply(aura: Aura?) {
		if let aura = aura {
			append("apply(aura: \(aura)")
		} else {
			append("apply(aura: nil)")
		}
	}

	public func apply(blendMode: BlendMode) {
		append("apply(blendMode: \(blendMode))")
	}

	public func apply(background: Palette<Color, GradientOptions>) {
		switch background {
		case .None:
			append("apply(background: nil)")
		case .Solid(let fillColor):
			append("apply(background: \(fillColor))")
		case .Gradient(let fillColors, let options):
			append("apply(background: \(fillColors), options: \(options))")
		}
	}

	public func apply(border: Palette<Color, GradientOptions>, width: Double) {
		var message = "apply(borderColor: "

		switch border {
		case .None:
			message += "nil"
		case .Solid(let borderColor):
			message += "\(borderColor)"
		case .Gradient(let borderColors, let options):
			message += "\(borderColors), options: \(options)"
		}

		message += " width: \(width)"

		append(message + ")")
	}

	public func apply(transform: Transform) {
		append("apply(transform: \(transform))")
	}

	public func fill() {
		append("fill() // rect")
	}

	public func stroke() {
		append("stroke() // rect")
	}
}
