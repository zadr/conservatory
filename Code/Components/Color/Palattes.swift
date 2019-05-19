public enum Model {
	case subtractive
	case additive
}

public extension Color {
	/**
	A primary color is defined as a color that exists without having to be combined with any other.

	- Parameter theory: The theory of light to use.

	- Returns: A list of primary colors for a given theory.
	*/
	
	func primary(_ model: Model = .subtractive) -> [Color] {
		switch model {
		case .subtractive:
			return [ Color.red, Color.yellow, Color.blue ]
		case .additive:
			return [ Color.red, Color.green, Color.blue ]
		}
	}

	/**
	A secondary color is defined as a color that exists when combined with another primary color.

	- Parameter theory: The theory of light to use.

	- Returns: A list of secondary colors for a given theory.
	*/
	func secondary(_ model: Model = .subtractive) -> [Color] {
		switch model {
		case .subtractive:
			return [ Color.orange, Color.purple, Color.green ]
		case .additive:
			return [ Color.yellow, Color.magenta, Color.cyan ]
		}
	}

	/**
	A tertiary color is defined as a color that exists when a primary color is combined with a secondary color.

	- Parameter theory: The theory of light to use.

	- Returns: A list of tertiary colors for a given theory.
	*/
	func tertiary(_ model: Model = .subtractive) -> [Color] {
		switch model {
		case .subtractive:
			return [ Color.vermilion, Color.amber, Color.chartreuse, Color.teal, Color.violet, Color.magenta ]
		case .additive:
			return [ Color.azure, Color.violet, Color.rose, Color.orange, Color.chartreuse, Color.springGreen ]
		}
	}

	// todo?: quaternary? quinary?

	/**
	A color is considered warm if it's associated with daylight or the sun. // todo: temperature-based description as well.

	Examples of warm colors are reds, oranges, yellows, browns and tans.

	- Returns: A list of warm colors.
	*/
	func warm() -> [Color] {
		return [
			Color(red: 254, green: 219, blue: 50).drift(),
			Color(red: 254, green: 168, blue: 55).drift(),
			Color(red: 254, green: 149, blue: 67).drift(),
			Color(red: 254, green: 104, blue: 36).drift()
		]
	}

	/**
	A color is considered cool if it's associated with an overcast sky or the winter. // todo: temperature-based description as well.

	Examples of cool colors are blues, violets, and greys.

	- Returns: A list of cool colors.
	*/
	func cool() -> [Color] {
		return [
			Color(red: 22, green: 128, blue: 115).drift(),
			Color(red: 20, green: 126, blue: 150).drift(),
			Color(red: 11, green: 74, blue: 132).drift(),
			Color(red: 3, green: 32, blue: 102).drift(),
			Color(red: 126, green: 24, blue: 126).drift()
		]
	}

	// todo: colors used on different media (oil, pastel, acrylic, watercolor, wax, etc) (for different purposes? Portrait vs Landscape vs…)
	// todo: seasonal colors: https://en.wikipedia.org/wiki/Color_analysis_(art)#Prominent_systems_of_.22seasonal.22_color_analysis
	// todo: actual seasonal colors: https://en.wikipedia.org/wiki/Color_analysis_(art)#Color_seasons
}
