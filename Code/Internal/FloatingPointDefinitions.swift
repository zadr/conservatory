// this all goes away in Swift 2.2

public extension Double {
	public static var positiveInfinity: Double {
		get { return 0b0111111111110000000000000000000000000000000000000000000000000000 }
	}

	public static var negativeInfinity: Double {
		get { return 0b1111111111110000000000000000000000000000000000000000000000000000 }
	}

	public static var minNormal: Double {
		get { return 0b0000000000010000000000000000000000000000000000000000000000000000 }
	}

	public static var minValue: Double {
		get { return 0b0000000000000000000000000000000000000000000000000000000000000001 }
	}

	public static var maxValue: Double {
		get { return 0b0111111111101111111111111111111111111111111111111111111111111111 }
	}

	public static var minExponent: Double {
		get { return 0b1100000010001111111100000000000000000000000000000000000000000000 }
	}

	public static var maxExponent: Double {
		get { return 0b0100000010001111111110000000000000000000000000000000000000000000 }
	}
}

public extension Float {
	public static var positiveInfinity: Float {
		get { return 0b01111111100000000000000000000000 }
	}

	public static var negativeInfinity: Float {
		get { return 0b11111111100000000000000000000000 }
	}

	public static var minNormal: Float {
		get { return 0b00000000100000000000000000000000 }
	}

	public static var minValue: Float {
		get { return 0b00000000000000000000000000000001 }
	}

	public static var maxValue: Float {
		get { return 0b01111111011111111111111111111111 }
	}

	public static var minExponent: Float {
		get { return 0b11000010111111000000000000000000 }
	}

	public static var maxExponent: Float {
		get { return 0b01000010111111100000000000000000 }
	}
}
