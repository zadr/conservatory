// MARK: Common colors

// todo: when writing docs, reference images in the playground, provide examples of all of the blend modes being applied

public extension Color {
	public static var black: Color {
		get { return Color(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0) }
	}

	public static var darkGray: Color {
		get { return Color(red: (1.0 / 3.0), green: (1.0 / 3.0), blue: (1.0 / 3.0), alpha: 1.0) }
	}

	public static var gray: Color {
		get { return Color(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0) }
	}

	public static var lightGray: Color {
		get { return Color(red: (2.0 / 3.0), green: (2.0 / 3.0), blue: (2.0 / 3.0), alpha: 1.0) }
	}

	public static var white: Color {
		get { return Color(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) }
	}

	public static var red: Color {
		get { return Color(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0) }
	}

	public static var orange: Color {
		get { return Color(red: 1.0, green: 0.5, blue: 0.0, alpha: 1.0) }
	}

	public static var yellow: Color {
		get { return Color(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0) }
	}

	public static var green: Color {
		get { return Color(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0) }
	}

	public static var blue: Color {
		get { return Color(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0) }
	}

	public static var cyan: Color {
		get { return Color(red: 0.0, green: 1.0, blue: 1.0, alpha: 1.0) }
	}

	public static var magenta: Color { // red-purple
		get { return Color(red: 1.0, green: 0.0, blue: 1.0, alpha: 1.0) }
	}

	public static var purple: Color {
		get { return Color(red: 0.5, green: 0.0, blue: 0.5, alpha: 1.0) }
	}

	public static var brown: Color {
		get { return Color(red: 0.6, green: 0.4, blue: 0.2, alpha: 1.0) }
	}

	public static var clear: Color {
		get { return Color(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0) }
	}
}

// MARK: - Web colors

public extension Color {
	public static var lightPink: Color {
		get { return Color(red: 1.00, green: 0.71, blue: 0.76, alpha: 1.0) }
	}

	public static var pink: Color {
		get { return Color(red: 1.00, green: 0.75, blue: 0.80, alpha: 1.0) }
	}

	public static var crimson: Color {
		get { return Color(red: 0.86, green: 0.08, blue: 0.24, alpha: 1.0) }
	}

	public static var lavenderBlush: Color {
		get { return Color(red: 1.00, green: 0.94, blue: 0.96, alpha: 1.0) }
	}

	public static var paleVioletRed: Color {
		get { return Color(red: 0.86, green: 0.44, blue: 0.58, alpha: 1.0) }
	}

	public static var hotPink: Color {
		get { return Color(red: 1.00, green: 0.41, blue: 0.71, alpha: 1.0) }
	}

	public static var deepPink: Color {
		get { return Color(red: 1.00, green: 0.08, blue: 0.58, alpha: 1.0) }
	}

	public static var mediumVioletRed: Color {
		get { return Color(red: 0.78, green: 0.08, blue: 0.52, alpha: 1.0) }
	}

	public static var orchid: Color {
		get { return Color(red: 0.85, green: 0.44, blue: 0.84, alpha: 1.0) }
	}

	public static var thistle: Color {
		get { return Color(red: 0.85, green: 0.75, blue: 0.85, alpha: 1.0) }
	}

	public static var plum: Color {
		get { return Color(red: 0.87, green: 0.63, blue: 0.87, alpha: 1.0) }
	}

	public static var violet: Color { // blue-purple
		get { return Color(red: 0.93, green: 0.51, blue: 0.93, alpha: 1.0) }
	}

	public static var fuchsia: Color {
		get { return Color(red: 1.00, green: 0.00, blue: 1.00, alpha: 1.0) }
	}

	public static var darkMagenta: Color {
		get { return Color(red: 0.55, green: 0.00, blue: 0.55, alpha: 1.0) }
	}

	public static var mediumOrchid: Color {
		get { return Color(red: 0.73, green: 0.33, blue: 0.83, alpha: 1.0) }
	}

	public static var darkViolet: Color {
		get { return Color(red: 0.58, green: 0.00, blue: 0.83, alpha: 1.0) }
	}

	public static var darkOrchid: Color {
		get { return Color(red: 0.60, green: 0.20, blue: 0.80, alpha: 1.0) }
	}

	public static var indigo: Color {
		get { return Color(red: 0.29, green: 0.00, blue: 0.51, alpha: 1.0) }
	}

	public static var blueViolet: Color {
		get { return Color(red: 0.54, green: 0.17, blue: 0.89, alpha: 1.0) }
	}

	public static var mediumPurple: Color {
		get { return Color(red: 0.58, green: 0.44, blue: 0.86, alpha: 1.0) }
	}

	public static var mediumSlateBlue: Color {
		get { return Color(red: 0.48, green: 0.41, blue: 0.93, alpha: 1.0) }
	}

	public static var slateBlue: Color {
		get { return Color(red: 0.42, green: 0.35, blue: 0.80, alpha: 1.0) }
	}

	public static var darkSlateBlue: Color {
		get { return Color(red: 0.28, green: 0.24, blue: 0.55, alpha: 1.0) }
	}

	public static var ghostWhite: Color {
		get { return Color(red: 0.97, green: 0.97, blue: 1.00, alpha: 1.0) }
	}

	public static var lavender: Color {
		get { return Color(red: 0.90, green: 0.90, blue: 0.98, alpha: 1.0) }
	}

	public static var mediumBlue: Color {
		get { return Color(red: 0.00, green: 0.00, blue: 0.80, alpha: 1.0) }
	}

	public static var darkBlue: Color {
		get { return Color(red: 0.00, green: 0.00, blue: 0.55, alpha: 1.0) }
	}

	public static var navy: Color {
		get { return Color(red: 0.00, green: 0.00, blue: 0.50, alpha: 1.0) }
	}

	public static var midnightBlue: Color {
		get { return Color(red: 0.10, green: 0.10, blue: 0.44, alpha: 1.0) }
	}

	public static var royalBlue: Color {
		get { return Color(red: 0.25, green: 0.41, blue: 0.88, alpha: 1.0) }
	}

	public static var cornflowerBlue: Color {
		get { return Color(red: 0.39, green: 0.58, blue: 0.93, alpha: 1.0) }
	}

	public static var lightSteelBlue: Color {
		get { return Color(red: 0.69, green: 0.77, blue: 0.87, alpha: 1.0) }
	}

	public static var lightSlateGray: Color {
		get { return Color(red: 0.47, green: 0.53, blue: 0.60, alpha: 1.0) }
	}

	public static var slateGray: Color {
		get { return Color(red: 0.44, green: 0.50, blue: 0.56, alpha: 1.0) }
	}

	public static var dodgerBlue: Color {
		get { return Color(red: 0.12, green: 0.56, blue: 1.00, alpha: 1.0) }
	}

	public static var aliceBlue: Color {
		get { return Color(red: 0.94, green: 0.97, blue: 1.00, alpha: 1.0) }
	}

	public static var steelBlue: Color {
		get { return Color(red: 0.27, green: 0.51, blue: 0.71, alpha: 1.0) }
	}

	public static var lightSkyBlue: Color {
		get { return Color(red: 0.53, green: 0.81, blue: 0.98, alpha: 1.0) }
	}

	public static var skyBlue: Color {
		get { return Color(red: 0.53, green: 0.81, blue: 0.92, alpha: 1.0) }
	}

	public static var deepSkyBlue: Color {
		get { return Color(red: 0.00, green: 0.75, blue: 1.00, alpha: 1.0) }
	}

	public static var lightBlue: Color {
		get { return Color(red: 0.68, green: 0.85, blue: 0.90, alpha: 1.0) }
	}

	public static var powderBlue: Color {
		get { return Color(red: 0.69, green: 0.88, blue: 0.90, alpha: 1.0) }
	}

	public static var cadetBlue: Color {
		get { return Color(red: 0.37, green: 0.62, blue: 0.63, alpha: 1.0) }
	}

	public static var darkTurquoise: Color {
		get { return Color(red: 0.00, green: 0.81, blue: 0.82, alpha: 1.0) }
	}

	public static var azure: Color {
		get { return Color(red: 0.94, green: 1.00, blue: 1.00, alpha: 1.0) }
	}

	public static var lightCyan: Color {
		get { return Color(red: 0.88, green: 1.00, blue: 1.00, alpha: 1.0) }
	}

	public static var paleTurquoise: Color {
		get { return Color(red: 0.69, green: 0.93, blue: 0.93, alpha: 1.0) }
	}

	public static var aqua: Color {
		get { return Color(red: 0.00, green: 1.00, blue: 1.00, alpha: 1.0) }
	}

	public static var darkCyan: Color {
		get { return Color(red: 0.00, green: 0.55, blue: 0.55, alpha: 1.0) }
	}

	public static var teal: Color { // blue-green
		get { return Color(red: 0.00, green: 0.50, blue: 0.50, alpha: 1.0) }
	}

	public static var darkSlateGray: Color {
		get { return Color(red: 0.18, green: 0.31, blue: 0.31, alpha: 1.0) }
	}

	public static var mediumTurquoise: Color {
		get { return Color(red: 0.28, green: 0.82, blue: 0.80, alpha: 1.0) }
	}

	public static var lightSeaGreen: Color {
		get { return Color(red: 0.13, green: 0.70, blue: 0.67, alpha: 1.0) }
	}

	public static var turquoise: Color {
		get { return Color(red: 0.25, green: 0.88, blue: 0.82, alpha: 1.0) }
	}

	public static var aquamarine: Color {
		get { return Color(red: 0.50, green: 1.00, blue: 0.83, alpha: 1.0) }
	}

	public static var mediumAquamarine: Color {
		get { return Color(red: 0.40, green: 0.80, blue: 0.67, alpha: 1.0) }
	}

	public static var mediumSpringGreen: Color {
		get { return Color(red: 0.00, green: 0.98, blue: 0.60, alpha: 1.0) }
	}

	public static var mintCream: Color {
		get { return Color(red: 0.96, green: 1.00, blue: 0.98, alpha: 1.0) }
	}

	public static var springGreen: Color {
		get { return Color(red: 0.00, green: 1.00, blue: 0.50, alpha: 1.0) }
	}

	public static var mediumSeaGreen: Color {
		get { return Color(red: 0.24, green: 0.70, blue: 0.44, alpha: 1.0) }
	}

	public static var seaGreen: Color {
		get { return Color(red: 0.18, green: 0.55, blue: 0.34, alpha: 1.0) }
	}

	public static var honeydew: Color {
		get { return Color(red: 0.94, green: 1.00, blue: 0.94, alpha: 1.0) }
	}

	public static var darkSeaGreen: Color {
		get { return Color(red: 0.56, green: 0.74, blue: 0.56, alpha: 1.0) }
	}

	public static var paleGreen: Color {
		get { return Color(red: 0.60, green: 0.98, blue: 0.60, alpha: 1.0) }
	}

	public static var lightGreen: Color {
		get { return Color(red: 0.56, green: 0.93, blue: 0.56, alpha: 1.0) }
	}

	public static var limeGreen: Color {
		get { return Color(red: 0.20, green: 0.80, blue: 0.20, alpha: 1.0) }
	}

	public static var lime: Color {
		get { return Color(red: 0.00, green: 1.00, blue: 0.00, alpha: 1.0) }
	}

	public static var forestGreen: Color {
		get { return Color(red: 0.13, green: 0.55, blue: 0.13, alpha: 1.0) }
	}

	public static var darkGreen: Color {
		get { return Color(red: 0.00, green: 0.39, blue: 0.00, alpha: 1.0) }
	}

	public static var lawnGreen: Color {
		get { return Color(red: 0.49, green: 0.99, blue: 0.00, alpha: 1.0) }
	}

	public static var chartreuse: Color {
		get { return Color(red: 0.50, green: 1.00, blue: 0.00, alpha: 1.0) }
	}

	public static var greenYellow: Color {
		get { return Color(red: 0.68, green: 1.00, blue: 0.18, alpha: 1.0) }
	}

	public static var darkOliveGreen: Color {
		get { return Color(red: 0.33, green: 0.42, blue: 0.18, alpha: 1.0) }
	}

	public static var yellowGreen: Color {
		get { return Color(red: 0.60, green: 0.80, blue: 0.20, alpha: 1.0) }
	}

	public static var oliveDrab: Color {
		get { return Color(red: 0.42, green: 0.56, blue: 0.14, alpha: 1.0) }
	}

	public static var ivory: Color {
		get { return Color(red: 1.00, green: 1.00, blue: 0.94, alpha: 1.0) }
	}

	public static var beige: Color {
		get { return Color(red: 0.96, green: 0.96, blue: 0.86, alpha: 1.0) }
	}

	public static var lightYellow: Color {
		get { return Color(red: 1.00, green: 1.00, blue: 0.88, alpha: 1.0) }
	}

	public static var lightGoldenrodYellow: Color {
		get { return Color(red: 0.98, green: 0.98, blue: 0.82, alpha: 1.0) }
	}

	public static var olive: Color {
		get { return Color(red: 0.50, green: 0.50, blue: 0.00, alpha: 1.0) }
	}

	public static var darkKhaki: Color {
		get { return Color(red: 0.74, green: 0.72, blue: 0.42, alpha: 1.0) }
	}

	public static var paleGoldenrod: Color {
		get { return Color(red: 0.93, green: 0.91, blue: 0.67, alpha: 1.0) }
	}

	public static var lemonChiffon: Color {
		get { return Color(red: 1.00, green: 0.98, blue: 0.80, alpha: 1.0) }
	}

	public static var khaki: Color {
		get { return Color(red: 0.94, green: 0.90, blue: 0.55, alpha: 1.0) }
	}

	public static var gold: Color {
		get { return Color(red: 1.00, green: 0.84, blue: 0.00, alpha: 1.0) }
	}

	public static var cornsilk: Color {
		get { return Color(red: 1.00, green: 0.97, blue: 0.86, alpha: 1.0) }
	}

	public static var goldenrod: Color {
		get { return Color(red: 0.85, green: 0.65, blue: 0.13, alpha: 1.0) }
	}

	public static var darkGoldenrod: Color {
		get { return Color(red: 0.72, green: 0.53, blue: 0.04, alpha: 1.0) }
	}

	public static var floralWhite: Color {
		get { return Color(red: 1.00, green: 0.98, blue: 0.94, alpha: 1.0) }
	}

	public static var oldLace: Color {
		get { return Color(red: 0.99, green: 0.96, blue: 0.90, alpha: 1.0) }
	}

	public static var wheat: Color {
		get { return Color(red: 0.96, green: 0.87, blue: 0.07, alpha: 1.0) }
	}

	public static var moccasin: Color {
		get { return Color(red: 1.00, green: 0.89, blue: 0.71, alpha: 1.0) }
	}

	public static var papayaWhip: Color {
		get { return Color(red: 1.00, green: 0.94, blue: 0.84, alpha: 1.0) }
	}

	public static var blanchedAlmond: Color {
		get { return Color(red: 1.00, green: 0.92, blue: 0.80, alpha: 1.0) }
	}

	public static var navajoWhite: Color {
		get { return Color(red: 1.00, green: 0.87, blue: 0.68, alpha: 1.0) }
	}

	public static var antiqueWhite: Color {
		get { return Color(red: 0.98, green: 0.92, blue: 0.84, alpha: 1.0) }
	}

	public static var tan: Color {
		get { return Color(red: 0.82, green: 0.71, blue: 0.55, alpha: 1.0) }
	}

	public static var burlywood: Color {
		get { return Color(red: 0.87, green: 0.72, blue: 0.53, alpha: 1.0) }
	}

	public static var darkOrange: Color {
		get { return Color(red: 1.00, green: 0.55, blue: 0.00, alpha: 1.0) }
	}

	public static var bisque: Color {
		get { return Color(red: 1.00, green: 0.89, blue: 0.77, alpha: 1.0) }
	}

	public static var linen: Color {
		get { return Color(red: 0.98, green: 0.94, blue: 0.90, alpha: 1.0) }
	}

	public static var peru: Color {
		get { return Color(red: 0.80, green: 0.52, blue: 0.25, alpha: 1.0) }
	}

	public static var peachPuff: Color {
		get { return Color(red: 1.00, green: 0.85, blue: 0.73, alpha: 1.0) }
	}

	public static var sandyBrown: Color {
		get { return Color(red: 0.96, green: 0.64, blue: 0.38, alpha: 1.0) }
	}

	public static var chocolate: Color {
		get { return Color(red: 0.82, green: 0.41, blue: 0.12, alpha: 1.0) }
	}

	public static var saddleBrown: Color {
		get { return Color(red: 0.55, green: 0.27, blue: 0.07, alpha: 1.0) }
	}

	public static var seashell: Color {
		get { return Color(red: 1.00, green: 0.96, blue: 0.93, alpha: 1.0) }
	}

	public static var sienna: Color {
		get { return Color(red: 0.63, green: 0.32, blue: 0.18, alpha: 1.0) }
	}

	public static var lightSalmon: Color {
		get { return Color(red: 1.00, green: 0.63, blue: 0.48, alpha: 1.0) }
	}

	public static var coral: Color {
		get { return Color(red: 1.00, green: 0.50, blue: 0.31, alpha: 1.0) }
	}

	public static var orangeRed: Color {
		get { return Color(red: 1.00, green: 0.27, blue: 0.00, alpha: 1.0) }
	}

	public static var darkSalmon: Color {
		get { return Color(red: 0.91, green: 0.59, blue: 0.48, alpha: 1.0) }
	}

	public static var tomato: Color {
		get { return Color(red: 1.00, green: 0.39, blue: 0.28, alpha: 1.0) }
	}

	public static var salmon: Color {
		get { return Color(red: 0.98, green: 0.50, blue: 0.45, alpha: 1.0) }
	}

	public static var mistyRose: Color {
		get { return Color(red: 1.00, green: 0.89, blue: 0.88, alpha: 1.0) }
	}

	public static var lightCoral: Color {
		get { return Color(red: 0.94, green: 0.50, blue: 0.50, alpha: 1.0) }
	}

	public static var snow: Color {
		get { return Color(red: 1.00, green: 0.98, blue: 0.98, alpha: 1.0) }
	}

	public static var rosyBrown: Color {
		get { return Color(red: 0.74, green: 0.56, blue: 0.56, alpha: 1.0) }
	}

	public static var indianRed: Color {
		get { return Color(red: 0.80, green: 0.36, blue: 0.36, alpha: 1.0) }
	}

	public static var fireBrick: Color {
		get { return Color(red: 0.70, green: 0.13, blue: 0.13, alpha: 1.0) }
	}

	public static var darkRed: Color {
		get { return Color(red: 0.55, green: 0.00, blue: 0.00, alpha: 1.0) }
	}

	public static var maroon: Color {
		get { return Color(red: 0.50, green: 0.00, blue: 0.00, alpha: 1.0) }
	}

	public static var whiteSmoke: Color {
		get { return Color(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.0) }
	}

	public static var gainsboro: Color {
		get { return Color(red: 0.86, green: 0.86, blue: 0.86, alpha: 1.0) }
	}

	public static var lightGrey: Color {
		get { return Color(red: 0.83, green: 0.83, blue: 0.83, alpha: 1.0) }
	}

	public static var silver: Color {
		get { return Color(red: 0.75, green: 0.75, blue: 0.75, alpha: 1.0) }
	}

	public static var grey: Color {
		get { return Color(red: 0.50, green: 0.50, blue: 0.50, alpha: 1.0) }
	}

	public static var dimGray: Color {
		get { return Color(red: 0.41, green: 0.41, blue: 0.41, alpha: 1.0) }
	}

	public static var dimGrey: Color {
		get { return Color(red: 0.41, green: 0.41, blue: 0.41, alpha: 1.0) }
	}

	public static var transparent: Color {
		get { return Color(red: 0.00, green: 0.00, blue: 0.00, alpha: 0.0) }
	}
	
	public static var bark: Color {
		get { return Color(red: 0.25, green: 0.19, blue: 0.13, alpha: 1.0) }
	}
}

// MARK: - Mixing results

public extension Color {
	public static var rose: Color {
		get { return Color(red: 234, green: 51, blue: 127) }
	}

	public static var vermilion: Color { // red-orange
		get { return Color(red: 236, green: 96, blue: 82) }
	}

	public static var amber: Color { // yellow-orange
		get { return Color(red: 247, green: 206, blue: 70) }
	}

	public static var russet: Color {
		get { return Color(red: 213, green: 130, blue: 115) }
	}

	public static var slate: Color {
		get { return Color(red: 152, green: 155, blue: 157) }
	}
}
