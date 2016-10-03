extension Int {
	/**
	Perform a task *Self* times, interruptable. eg:

	- Parameter body: A closure to call *Self* times. This closure in turn takes two parameters, *Int*, the current iteration value and *UnsafeMutablePointer<Bool>*, a pointer to memory to allow for early stopping of execution.

	```
	var positions = [Double]()
	angle.times { (x, stop) in
		let degrees = (x * angle)
		positions.append(degrees)

		// we don't want to wrap around
		// and allow any values to overlap
		if degrees > 360.0 {
			stop.memory = true
		}
	}
	```
	*/
	public func times(body: (Int, UnsafeMutablePointer<Bool>) throws -> Void) rethrows {
		for i in 0 ..< self {
			var stop = false
			try body(i, &stop)

			if stop {
				break
			}
		}
	}

	/**
	Perform a task *Self* times, keeping track of the result.

	- Parameter body: A closure to call *Self* times. This closure in turn takes one parameters, *Int*, the current iteration value. This closure is expected to return a value upon exit.

	- Returns: A list of the results returned by each call of the closure passed in.

	```
	var transformedShapes = 36.times { (x, _) in
		var shape = Shape(oval: Size(width: 100, height: 50))
		shape.transform = Transform.rotate(Double(x * 36))
		return shape
	}
	canvas.add(transformedShapes)
	```
	*/
	public func map<T>(transform: (Int) throws -> T) rethrows -> [T] {
		var results = [T]()
		for i in 0 ..< self {
			let result = try transform(i)
			results.append(result)
		}

		return results
	}

	/**
	- Returns: The absolute value of *Self*.
	*/
	public var absoluteValue: Int {
		if self > 0 {
			return self
		}

		return -self
	}

	/**
	- Returns: The greatest common divisor that two numbers have.

	`8.greatestCommonDivisor(12)` is `4`.

	Calculated with a recursive version of [Euclidean's Algorithm](https://en.wikipedia.org/wiki/Euclidean_algorithm).
	*/
	public func greatestCommonDivisor(y _y: Int) -> Int {
		let x = absoluteValue, y = _y.absoluteValue
		if y == 0 {
			return x
		}

		return _y.greatestCommonDivisor(y: (x % y))
	}

	/**
	- Returns: *true* if two numbers are [coprime](https://en.wikipedia.org/wiki/Coprime_integers), that is, if the greatest common divisor of the pair is 1.
	
	`7.coprime(with: 3)` is *true*, while `12.coprime(with: 24)` is *false*.
	*/
	public func coprime(with _y: Int) -> Bool {
		return greatestCommonDivisor(y: _y) == 1
	}
}
