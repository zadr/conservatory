public extension String {
	/**
	- Returns: A *Range<String.Index>* that will cover the entirety of *Self*.
	*/
	public var encompassingRange: Range<Index> {
		get {
			return Range<Index>(start: startIndex, end: endIndex)
		}
	}
}
