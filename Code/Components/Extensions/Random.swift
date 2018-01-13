public extension UInt {
	/**
	- Returns: A random value.

	- Parameter range: The range of values to return. The default value is 0 ... **UInt.max**, or **18446744073709551615**.
	*/
	public static func random(_ range: CountableClosedRange<UInt> = 0 ... UInt.max) -> UInt {
		return (MT19937_64_random() % (range.upperBound - range.lowerBound)) + range.lowerBound
	}
}

public extension Int {
	/**
	- Returns: A random value.

	- Parameter range: The range of values to return. The default value is **Int.min**, or **-9223372036854775808** ... **UInt.max**, or **18446744073709551615**.
	*/
	public static func random(_ range: CountableClosedRange<Int> = Int.min ... Int.max) -> Int {
		let value = Int(UInt.random() % UInt(Int.max))
		return (value % (range.upperBound - range.lowerBound)) + range.lowerBound
	}
}

public extension UInt8 {
	/**
	- Returns: a random value.

	- Parameter range: The range of values to return. The default value is 0 ... **UInt8.max**, or **255**
	*/
	public static func random(_ range: CountableClosedRange<UInt8> = 0 ... UInt8.max) -> UInt8 {
		let value = UInt8(UInt.random() % UInt(UInt8.max))
		return (value % (range.upperBound - range.lowerBound)) + range.lowerBound
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
