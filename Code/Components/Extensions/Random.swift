public extension UInt {
	/**
	- Returns: A random value.

	- Parameter max: The maximum value to return. The default value is **UInt.max**, or **18446744073709551615**.
	- Parameter min: The minimum value to return. The default value is **0**.
	*/
	public static func random(_ max: UInt = UInt.max, min: UInt = 0) -> UInt {
		return (MT19937_64_random() % (max - min)) + min
	}
}

public extension Int {
	/**
	- Returns: A random value.

	- Parameter max: The maximum value to return. The default value is **Int.max**, or **9223372036854775807**.
	- Parameter min: The minimum value to return. The default value is **Int.min**, or **-9223372036854775808**.
	*/
	public static func random(_ max: Int = Int.max, min: Int = Int.min) -> Int {
		let value = Int(UInt.random() % UInt(Int.max))
		return (value % (max - min)) + min
	}
}

public extension UInt8 {
	/**
	- Returns: a random value.

	- Parameter max: The maximum value to return. The default value is **UInt8.max**, or **255**
	- Parameter min: The minimum value to return. The default value is **0**.
	*/
	public static func random(_ max: UInt8 = UInt8.max, min: UInt8 = 0) -> UInt8 {
		let value = UInt8(UInt.random() % UInt(UInt8.max))
		return (value % (max - min)) + min
	}
}

public extension Bool {
	/**
	- Returns: a random value.
	*/
	public static func random() -> Bool {
		let value = UInt.random() % 2
		return value == 0
	}
}
