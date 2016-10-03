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

	public func render(_ viewable: Viewable) -> RenderResultType? {
		return render([ viewable ])
	}

	public func render(_ viewables: [Viewable]) -> RenderResultType? {
		level += 1; defer { level -= 1 }

		viewables.forEach({
			if level > 0 {
				append("// \(String(describing: type(of: $0)))")
			}

			$0.render(self)
		})

		return stringContext
	}

	private func append(_ string: String) {
		let tabs = String(repeating: "\t", count: level)
		stringContext += tabs + string + "\n"
	}

	public func draw(_ bezier: Bezier) {
		append("draw(bezier: \(bezier))")
	}

	public func draw(_ image: Image) {
		append("draw(image: \(image))")
	}

	public func draw(_ text: String, withTextEffects effects: [TextEffect]) {
		append("draw(text: \(text), withTextEffects: \(effects)")
	}

	public func apply(_ aura: Aura?) {
		if let aura = aura {
			append("apply(aura: \(aura)")
		} else {
			append("apply(aura: nil)")
		}
	}

	public func apply(_ blendMode: BlendMode) {
		append("apply(blendMode: \(blendMode))")
	}

	public func apply(_ background: Palette<Color, GradientOptions>) {
		switch background {
		case .none:
			append("apply(background: nil)")
		case .solid(let fillColor):
			append("apply(background: \(fillColor))")
		case .gradient(let fillColors, let options):
			append("apply(background: \(fillColors), options: \(options))")
		}
	}

	public func apply(_ border: Palette<Color, GradientOptions>, width: Double) {
		var message = "apply(borderColor: "

		switch border {
		case .none:
			message += "nil"
		case .solid(let borderColor):
			message += "\(borderColor)"
		case .gradient(let borderColors, let options):
			message += "\(borderColors), options: \(options)"
		}

		message += " width: \(width)"

		append(message + ")")
	}

	public func apply(_ transform: Transform) {
		append("apply(transform: \(transform))")
	}

	public func fill() {
		append("fill() // rect")
	}

	public func stroke() {
		append("stroke() // rect")
	}
}
