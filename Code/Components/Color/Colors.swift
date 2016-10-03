// MARK: Common colors

// todo: when writing docs, reference images in the playground, provide examples of all of the blend modes being applied

public extension Color {
	public static var black: Color {
		return Color(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
	}

	public static var darkGray: Color {
		return Color(red: (1.0 / 3.0), green: (1.0 / 3.0), blue: (1.0 / 3.0), alpha: 1.0)
	}

	public static var gray: Color {
		return Color(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
	}

	public static var lightGray: Color {
		return Color(red: (2.0 / 3.0), green: (2.0 / 3.0), blue: (2.0 / 3.0), alpha: 1.0)
	}

	public static var white: Color {
		return Color(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
	}

	public static var red: Color {
		return Color(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
	}

	public static var orange: Color {
		return Color(red: 1.0, green: 0.5, blue: 0.0, alpha: 1.0)
	}

	public static var yellow: Color {
		return Color(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)
	}

	public static var green: Color {
		return Color(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0)
	}

	public static var blue: Color {
		return Color(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0)
	}

	public static var cyan: Color {
		return Color(red: 0.0, green: 1.0, blue: 1.0, alpha: 1.0)
	}

	public static var magenta: Color { // red-purple
		return Color(red: 1.0, green: 0.0, blue: 1.0, alpha: 1.0)
	}

	public static var purple: Color {
		return Color(red: 0.5, green: 0.0, blue: 0.5, alpha: 1.0)
	}

	public static var brown: Color {
		return Color(red: 0.6, green: 0.4, blue: 0.2, alpha: 1.0)
	}

	public static var clear: Color {
		return Color(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
	}
}

// MARK: - Web colors

public extension Color {
	public static var lightPink: Color {
		return Color(red: 1.00, green: 0.71, blue: 0.76, alpha: 1.0)
	}

	public static var pink: Color {
		return Color(red: 1.00, green: 0.75, blue: 0.80, alpha: 1.0)
	}

	public static var crimson: Color {
		return Color(red: 0.86, green: 0.08, blue: 0.24, alpha: 1.0)
	}

	public static var lavenderBlush: Color {
		return Color(red: 1.00, green: 0.94, blue: 0.96, alpha: 1.0)
	}

	public static var paleVioletRed: Color {
		return Color(red: 0.86, green: 0.44, blue: 0.58, alpha: 1.0)
	}

	public static var hotPink: Color {
		return Color(red: 1.00, green: 0.41, blue: 0.71, alpha: 1.0)
	}

	public static var deepPink: Color {
		return Color(red: 1.00, green: 0.08, blue: 0.58, alpha: 1.0)
	}

	public static var mediumVioletRed: Color {
		return Color(red: 0.78, green: 0.08, blue: 0.52, alpha: 1.0)
	}

	public static var orchid: Color {
		return Color(red: 0.85, green: 0.44, blue: 0.84, alpha: 1.0)
	}

	public static var thistle: Color {
		return Color(red: 0.85, green: 0.75, blue: 0.85, alpha: 1.0)
	}

	public static var plum: Color {
		return Color(red: 0.87, green: 0.63, blue: 0.87, alpha: 1.0)
	}

	public static var violet: Color { // blue-purple
		return Color(red: 0.93, green: 0.51, blue: 0.93, alpha: 1.0)
	}

	public static var fuchsia: Color {
		return Color(red: 1.00, green: 0.00, blue: 1.00, alpha: 1.0)
	}

	public static var darkMagenta: Color {
		return Color(red: 0.55, green: 0.00, blue: 0.55, alpha: 1.0)
	}

	public static var mediumOrchid: Color {
		return Color(red: 0.73, green: 0.33, blue: 0.83, alpha: 1.0)
	}

	public static var darkViolet: Color {
		return Color(red: 0.58, green: 0.00, blue: 0.83, alpha: 1.0)
	}

	public static var darkOrchid: Color {
		return Color(red: 0.60, green: 0.20, blue: 0.80, alpha: 1.0)
	}

	public static var indigo: Color {
		return Color(red: 0.29, green: 0.00, blue: 0.51, alpha: 1.0)
	}

	public static var blueViolet: Color {
		return Color(red: 0.54, green: 0.17, blue: 0.89, alpha: 1.0)
	}

	public static var mediumPurple: Color {
		return Color(red: 0.58, green: 0.44, blue: 0.86, alpha: 1.0)
	}

	public static var mediumSlateBlue: Color {
		return Color(red: 0.48, green: 0.41, blue: 0.93, alpha: 1.0)
	}

	public static var slateBlue: Color {
		return Color(red: 0.42, green: 0.35, blue: 0.80, alpha: 1.0)
	}

	public static var darkSlateBlue: Color {
		return Color(red: 0.28, green: 0.24, blue: 0.55, alpha: 1.0)
	}

	public static var ghostWhite: Color {
		return Color(red: 0.97, green: 0.97, blue: 1.00, alpha: 1.0)
	}

	public static var lavender: Color {
		return Color(red: 0.90, green: 0.90, blue: 0.98, alpha: 1.0)
	}

	public static var mediumBlue: Color {
		return Color(red: 0.00, green: 0.00, blue: 0.80, alpha: 1.0)
	}

	public static var darkBlue: Color {
		return Color(red: 0.00, green: 0.00, blue: 0.55, alpha: 1.0)
	}

	public static var navy: Color {
		return Color(red: 0.00, green: 0.00, blue: 0.50, alpha: 1.0)
	}

	public static var midnightBlue: Color {
		return Color(red: 0.10, green: 0.10, blue: 0.44, alpha: 1.0)
	}

	public static var royalBlue: Color {
		return Color(red: 0.25, green: 0.41, blue: 0.88, alpha: 1.0)
	}

	public static var cornflowerBlue: Color {
		return Color(red: 0.39, green: 0.58, blue: 0.93, alpha: 1.0)
	}

	public static var lightSteelBlue: Color {
		return Color(red: 0.69, green: 0.77, blue: 0.87, alpha: 1.0)
	}

	public static var lightSlateGray: Color {
		return Color(red: 0.47, green: 0.53, blue: 0.60, alpha: 1.0)
	}

	public static var slateGray: Color {
		return Color(red: 0.44, green: 0.50, blue: 0.56, alpha: 1.0)
	}

	public static var dodgerBlue: Color {
		return Color(red: 0.12, green: 0.56, blue: 1.00, alpha: 1.0)
	}

	public static var aliceBlue: Color {
		return Color(red: 0.94, green: 0.97, blue: 1.00, alpha: 1.0)
	}

	public static var steelBlue: Color {
		return Color(red: 0.27, green: 0.51, blue: 0.71, alpha: 1.0)
	}

	public static var lightSkyBlue: Color {
		return Color(red: 0.53, green: 0.81, blue: 0.98, alpha: 1.0)
	}

	public static var skyBlue: Color {
		return Color(red: 0.53, green: 0.81, blue: 0.92, alpha: 1.0)
	}

	public static var deepSkyBlue: Color {
		return Color(red: 0.00, green: 0.75, blue: 1.00, alpha: 1.0)
	}

	public static var lightBlue: Color {
		return Color(red: 0.68, green: 0.85, blue: 0.90, alpha: 1.0)
	}

	public static var powderBlue: Color {
		return Color(red: 0.69, green: 0.88, blue: 0.90, alpha: 1.0)
	}

	public static var cadetBlue: Color {
		return Color(red: 0.37, green: 0.62, blue: 0.63, alpha: 1.0)
	}

	public static var darkTurquoise: Color {
		return Color(red: 0.00, green: 0.81, blue: 0.82, alpha: 1.0)
	}

	public static var azure: Color {
		return Color(red: 0.94, green: 1.00, blue: 1.00, alpha: 1.0)
	}

	public static var lightCyan: Color {
		return Color(red: 0.88, green: 1.00, blue: 1.00, alpha: 1.0)
	}

	public static var paleTurquoise: Color {
		return Color(red: 0.69, green: 0.93, blue: 0.93, alpha: 1.0)
	}

	public static var aqua: Color {
		return Color(red: 0.00, green: 1.00, blue: 1.00, alpha: 1.0)
	}

	public static var darkCyan: Color {
		return Color(red: 0.00, green: 0.55, blue: 0.55, alpha: 1.0)
	}

	public static var teal: Color { // blue-green
		return Color(red: 0.00, green: 0.50, blue: 0.50, alpha: 1.0)
	}

	public static var darkSlateGray: Color {
		return Color(red: 0.18, green: 0.31, blue: 0.31, alpha: 1.0)
	}

	public static var mediumTurquoise: Color {
		return Color(red: 0.28, green: 0.82, blue: 0.80, alpha: 1.0)
	}

	public static var lightSeaGreen: Color {
		return Color(red: 0.13, green: 0.70, blue: 0.67, alpha: 1.0)
	}

	public static var turquoise: Color {
		return Color(red: 0.25, green: 0.88, blue: 0.82, alpha: 1.0)
	}

	public static var aquamarine: Color {
		return Color(red: 0.50, green: 1.00, blue: 0.83, alpha: 1.0)
	}

	public static var mediumAquamarine: Color {
		return Color(red: 0.40, green: 0.80, blue: 0.67, alpha: 1.0)
	}

	public static var mediumSpringGreen: Color {
		return Color(red: 0.00, green: 0.98, blue: 0.60, alpha: 1.0)
	}

	public static var mintCream: Color {
		return Color(red: 0.96, green: 1.00, blue: 0.98, alpha: 1.0)
	}

	public static var springGreen: Color {
		return Color(red: 0.00, green: 1.00, blue: 0.50, alpha: 1.0)
	}

	public static var mediumSeaGreen: Color {
		return Color(red: 0.24, green: 0.70, blue: 0.44, alpha: 1.0)
	}

	public static var seaGreen: Color {
		return Color(red: 0.18, green: 0.55, blue: 0.34, alpha: 1.0)
	}

	public static var honeydew: Color {
		return Color(red: 0.94, green: 1.00, blue: 0.94, alpha: 1.0)
	}

	public static var darkSeaGreen: Color {
		return Color(red: 0.56, green: 0.74, blue: 0.56, alpha: 1.0)
	}

	public static var paleGreen: Color {
		return Color(red: 0.60, green: 0.98, blue: 0.60, alpha: 1.0)
	}

	public static var lightGreen: Color {
		return Color(red: 0.56, green: 0.93, blue: 0.56, alpha: 1.0)
	}

	public static var limeGreen: Color {
		return Color(red: 0.20, green: 0.80, blue: 0.20, alpha: 1.0)
	}

	public static var lime: Color {
		return Color(red: 0.00, green: 1.00, blue: 0.00, alpha: 1.0)
	}

	public static var forestGreen: Color {
		return Color(red: 0.13, green: 0.55, blue: 0.13, alpha: 1.0)
	}

	public static var darkGreen: Color {
		return Color(red: 0.00, green: 0.39, blue: 0.00, alpha: 1.0)
	}

	public static var lawnGreen: Color {
		return Color(red: 0.49, green: 0.99, blue: 0.00, alpha: 1.0)
	}

	public static var chartreuse: Color {
		return Color(red: 0.50, green: 1.00, blue: 0.00, alpha: 1.0)
	}

	public static var greenYellow: Color {
		return Color(red: 0.68, green: 1.00, blue: 0.18, alpha: 1.0)
	}

	public static var darkOliveGreen: Color {
		return Color(red: 0.33, green: 0.42, blue: 0.18, alpha: 1.0)
	}

	public static var yellowGreen: Color {
		return Color(red: 0.60, green: 0.80, blue: 0.20, alpha: 1.0)
	}

	public static var oliveDrab: Color {
		return Color(red: 0.42, green: 0.56, blue: 0.14, alpha: 1.0)
	}

	public static var ivory: Color {
		return Color(red: 1.00, green: 1.00, blue: 0.94, alpha: 1.0)
	}

	public static var beige: Color {
		return Color(red: 0.96, green: 0.96, blue: 0.86, alpha: 1.0)
	}

	public static var lightYellow: Color {
		return Color(red: 1.00, green: 1.00, blue: 0.88, alpha: 1.0)
	}

	public static var lightGoldenrodYellow: Color {
		return Color(red: 0.98, green: 0.98, blue: 0.82, alpha: 1.0)
	}

	public static var olive: Color {
		return Color(red: 0.50, green: 0.50, blue: 0.00, alpha: 1.0)
	}

	public static var darkKhaki: Color {
		return Color(red: 0.74, green: 0.72, blue: 0.42, alpha: 1.0)
	}

	public static var paleGoldenrod: Color {
		return Color(red: 0.93, green: 0.91, blue: 0.67, alpha: 1.0)
	}

	public static var lemonChiffon: Color {
		return Color(red: 1.00, green: 0.98, blue: 0.80, alpha: 1.0)
	}

	public static var khaki: Color {
		return Color(red: 0.94, green: 0.90, blue: 0.55, alpha: 1.0)
	}

	public static var gold: Color {
		return Color(red: 1.00, green: 0.84, blue: 0.00, alpha: 1.0)
	}

	public static var cornsilk: Color {
		return Color(red: 1.00, green: 0.97, blue: 0.86, alpha: 1.0)
	}

	public static var goldenrod: Color {
		return Color(red: 0.85, green: 0.65, blue: 0.13, alpha: 1.0)
	}

	public static var darkGoldenrod: Color {
		return Color(red: 0.72, green: 0.53, blue: 0.04, alpha: 1.0)
	}

	public static var floralWhite: Color {
		return Color(red: 1.00, green: 0.98, blue: 0.94, alpha: 1.0)
	}

	public static var oldLace: Color {
		return Color(red: 0.99, green: 0.96, blue: 0.90, alpha: 1.0)
	}

	public static var wheat: Color {
		return Color(red: 0.96, green: 0.87, blue: 0.07, alpha: 1.0)
	}

	public static var moccasin: Color {
		return Color(red: 1.00, green: 0.89, blue: 0.71, alpha: 1.0)
	}

	public static var papayaWhip: Color {
		return Color(red: 1.00, green: 0.94, blue: 0.84, alpha: 1.0)
	}

	public static var blanchedAlmond: Color {
		return Color(red: 1.00, green: 0.92, blue: 0.80, alpha: 1.0)
	}

	public static var navajoWhite: Color {
		return Color(red: 1.00, green: 0.87, blue: 0.68, alpha: 1.0)
	}

	public static var antiqueWhite: Color {
		return Color(red: 0.98, green: 0.92, blue: 0.84, alpha: 1.0)
	}

	public static var tan: Color {
		return Color(red: 0.82, green: 0.71, blue: 0.55, alpha: 1.0)
	}

	public static var burlywood: Color {
		return Color(red: 0.87, green: 0.72, blue: 0.53, alpha: 1.0)
	}

	public static var darkOrange: Color {
		return Color(red: 1.00, green: 0.55, blue: 0.00, alpha: 1.0)
	}

	public static var bisque: Color {
		return Color(red: 1.00, green: 0.89, blue: 0.77, alpha: 1.0)
	}

	public static var linen: Color {
		return Color(red: 0.98, green: 0.94, blue: 0.90, alpha: 1.0)
	}

	public static var peru: Color {
		return Color(red: 0.80, green: 0.52, blue: 0.25, alpha: 1.0)
	}

	public static var peachPuff: Color {
		return Color(red: 1.00, green: 0.85, blue: 0.73, alpha: 1.0)
	}

	public static var sandyBrown: Color {
		return Color(red: 0.96, green: 0.64, blue: 0.38, alpha: 1.0)
	}

	public static var chocolate: Color {
		return Color(red: 0.82, green: 0.41, blue: 0.12, alpha: 1.0)
	}

	public static var saddleBrown: Color {
		return Color(red: 0.55, green: 0.27, blue: 0.07, alpha: 1.0)
	}

	public static var seashell: Color {
		return Color(red: 1.00, green: 0.96, blue: 0.93, alpha: 1.0)
	}

	public static var sienna: Color {
		return Color(red: 0.63, green: 0.32, blue: 0.18, alpha: 1.0)
	}

	public static var lightSalmon: Color {
		return Color(red: 1.00, green: 0.63, blue: 0.48, alpha: 1.0)
	}

	public static var coral: Color {
		return Color(red: 1.00, green: 0.50, blue: 0.31, alpha: 1.0)
	}

	public static var orangeRed: Color {
		return Color(red: 1.00, green: 0.27, blue: 0.00, alpha: 1.0)
	}

	public static var darkSalmon: Color {
		return Color(red: 0.91, green: 0.59, blue: 0.48, alpha: 1.0)
	}

	public static var tomato: Color {
		return Color(red: 1.00, green: 0.39, blue: 0.28, alpha: 1.0)
	}

	public static var salmon: Color {
		return Color(red: 0.98, green: 0.50, blue: 0.45, alpha: 1.0)
	}

	public static var mistyRose: Color {
		return Color(red: 1.00, green: 0.89, blue: 0.88, alpha: 1.0)
	}

	public static var lightCoral: Color {
		return Color(red: 0.94, green: 0.50, blue: 0.50, alpha: 1.0)
	}

	public static var snow: Color {
		return Color(red: 1.00, green: 0.98, blue: 0.98, alpha: 1.0)
	}

	public static var rosyBrown: Color {
		return Color(red: 0.74, green: 0.56, blue: 0.56, alpha: 1.0)
	}

	public static var indianRed: Color {
		return Color(red: 0.80, green: 0.36, blue: 0.36, alpha: 1.0)
	}

	public static var fireBrick: Color {
		return Color(red: 0.70, green: 0.13, blue: 0.13, alpha: 1.0)
	}

	public static var darkRed: Color {
		return Color(red: 0.55, green: 0.00, blue: 0.00, alpha: 1.0)
	}

	public static var maroon: Color {
		return Color(red: 0.50, green: 0.00, blue: 0.00, alpha: 1.0)
	}

	public static var whiteSmoke: Color {
		return Color(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.0)
	}

	public static var gainsboro: Color {
		return Color(red: 0.86, green: 0.86, blue: 0.86, alpha: 1.0)
	}

	public static var lightGrey: Color {
		return Color(red: 0.83, green: 0.83, blue: 0.83, alpha: 1.0)
	}

	public static var silver: Color {
		return Color(red: 0.75, green: 0.75, blue: 0.75, alpha: 1.0)
	}

	public static var grey: Color {
		return Color(red: 0.50, green: 0.50, blue: 0.50, alpha: 1.0)
	}

	public static var dimGray: Color {
		return Color(red: 0.41, green: 0.41, blue: 0.41, alpha: 1.0)
	}

	public static var dimGrey: Color {
		return Color(red: 0.41, green: 0.41, blue: 0.41, alpha: 1.0)
	}

	public static var transparent: Color {
		return Color(red: 0.00, green: 0.00, blue: 0.00, alpha: 0.0)
	}
	
	public static var bark: Color {
		return Color(red: 0.25, green: 0.19, blue: 0.13, alpha: 1.0)
	}
}

// MARK: - Mixing results

public extension Color {
	public static var rose: Color {
		return Color(red: 234, green: 51, blue: 127)
	}

	public static var vermilion: Color { // red-orange
		return Color(red: 236, green: 96, blue: 82)
	}

	public static var amber: Color { // yellow-orange
		return Color(red: 247, green: 206, blue: 70)
	}

	public static var russet: Color {
		return Color(red: 213, green: 130, blue: 115)
	}

	public static var slate: Color {
		return Color(red: 152, green: 155, blue: 157)
	}
}
