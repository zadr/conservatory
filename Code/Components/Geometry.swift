/**
The native Point type in Conservatory, used to represent an x, y coordinate on a coordinate system .
*/
public struct Point {
	public let x: Double
	public let y: Double

	/**
	Initialize a *Point* object by passing in *x*, and *y* values as *Int*s.

	- Parameter x: An integral value that controls the *x* value. There is no default value.
	- Parameter y: A integral value that controls the *y* channel. There is no default value.
	*/
	public init(x _x: Int, y _y: Int) {
		self.init(x: Double(_x), y: Double(_y))
	}

	/**
	Initialize a *Point* object by passing in *x*, and *y* values as *Double*s.

	- Parameter x: A decimal value that controls the *x* value. The default value is **0.0**.
	- Parameter y: A decimal value that controls the *y* channel. The default value is **0.0**.
	*/
	public init(x _x: Double = 0.0, y _y: Double = 0.0) {
		x = _x
		y = _y
	}

	/**
	- Returns: An empty Point, with the *x* and *y* values of **0.0**.
	*/
	public static var zero: Point {
		return Point()
	}

	/**
	- Parameter transform: A *Transform* to apply to the a point.

	- Returns: A new *Point*.
	*/
	public func apply(_ transform: Transform) -> Point {
		return transform.apply(to: self)
	}

	/**
	- Parameter point: A second point in the current coordinate space.

	- Returns: The angle required to join two points together.
	*/
	public func angle(_ point: Point) -> Double {
		return Degree(degrees: (point.y - y).arcTangent(point.x - x))
	}

	/**
	- Parameter point: A second point in the current coordinate space.

	- Returns: The distance between two points.
	*/
	public func distance(_ point: Point) -> Double {
		return Degree(degrees: ((point.x - x).squareRoot() ** 2) + ((point.y - y) ** 2))
	}

	/**
	- Parameter radius: How far away from the current coordinate are we going.
	- Parameter angle: How far to rotate from the current coordinate before drawing a line *radius* units long.

	- Returns: A new coordinate radius units away at angle° from the current point.
	*/
	
	public func coordinate(_ radius: Double, angle: Degree) -> Point {
		precondition(angle > -360.0)
		precondition(angle < 360.0)

		return Point(
			x: Radian(angle).cosine * radius,
			y: Radian(angle).sine * radius
		)
	}
}

extension Point: CustomStringConvertible {
	public var description: String {
		return "Point(x: \(x), y: \(y))"
	}
}

extension Point: Hashable {
	public func hash(into hasher: inout Hasher) {
		hasher.combine(x)
		hasher.combine(y)
		_ = hasher.finalize()
	}
}

public func ==(x: Point, y: Point) -> Bool {
	return x.x == y.x && x.y == y.y
}

public func +(x: Point, y: Point) -> Point {
	return Point(x: x.x + y.x, y: x.y + y.y)
}

public func -(x: Point, y: Point) -> Point {
	return Point(x: x.x - y.x, y: x.y - y.y)
}

public func +=(x: inout Point, y: Point) {
	x = x + y
}

public func -=(x: inout Point, y: Point) {
	x = x - y
}

// MARK: -

/**
The native Size type in Conservatory, used to represent the width and height of an object in a coordinate system.
*/
public struct Size {
	public var width: Double
	public var height: Double

	/**
	Initialize a *Size* object by passing in *width*, and *height* values as *Int*s.

	- Parameter width: An integral value that controls the *width* value. There is no default value.
	- Parameter height: A integral value that controls the *height* channel. There is no default value.
	*/
	public init(width _width: Int, height _height: Int) {
		self.init(width: Double(_width), height: Double(_height))
	}

	/**
	Initialize a *Size* object by passing in *width*, and *height* values as *Double*s.

	- Parameter width: A decimal value that controls the *width* value. The default value is **0.0**.
	- Parameter height: A decimal value that controls the *height* channel. The default value is **0.0**.
	*/
	public init(width _width: Double = 0.0, height _height: Double = 0.0) {
		width = _width
		height = _height
	}

	/**
	- Returns: An empty Size, with the *width* and *height* values of **0.0**.
	*/
	public static var zero: Size {
		return Size()
	}
}

extension Size: CustomStringConvertible {
	public var description: String {
		return "Size(width: \(width), height: \(height))"
	}
}

extension Size: Hashable {
	public func hash(into hasher: inout Hasher) {
		hasher.combine(width)
		hasher.combine(height)
		_ = hasher.finalize()
	}
}

public func ==(x: Size, y: Size) -> Bool {
	return x.width == y.width && x.height == y.height
}

public func +(x: Size, y: Size) -> Size {
	return Size(width: x.width + y.width, height: x.height + y.height)
}

public func -(x: Size, y: Size) -> Size {
	return Size(width: x.width - y.width, height: x.height - y.height)
}

public func *(x: Size, y: Double) -> Size {
	return Size(width: x.width * y, height: x.height * y)
}

public func /(x: Size, y: Double) -> Size {
	return Size(width: x.width / y, height: x.height / y)
}

public func +=(x: inout Size, y: Size) {
	x = x + y
}

public func -=(x: inout Size, y: Size) {
	x = x - y
}

public func *=(x: inout Size, y: Double) {
	x = x * y
}

public func /=(x: inout Size, y: Double) {
	x = x / y
}

// MARK: -

/**
A *Grid* is an enumeration to represent dimensions of a coordinate system.
*/
public enum Grid {
	/**
	A *Column* is an enumeration of vertical positions within a coordinate system.
	*/
	public enum Column {
		case top
		case middle
		case bottom
	}

	/**
	A *Row* is an enumeration of horizontal positions within a coordinate system.
	*/
	public enum Row {
		case left
		case center
		case right
	}
}

// Do we really need this?
/**
The native bounding box type in Conservatory, combines a *Point* and a *Size* to represent the area and volume of an object in a coordinate system.
*/
public struct Box {
	public var location: Point
	public var size: Size

	/**
	Initialize a *Box* object by passing in a *location*, and *size* values.

	- Parameter location: A *Point* that represents the topmost, leftmost corner of a bounding box.
	- Parameter size: A *Size* that represents the area of a bounding box.
	*/
	public init(location _location: Point = Point.zero, size _size: Size = Size.zero) {
		location = _location
		size = _size
	}

	/**
	- Returns: an empty *Box*, equivalent to `Box(Point.zero, size: Size.zero)`.
	*/
	public static var zero: Box {
		return Box()
	}

	/**
	- Returns: the *Point* of a requested section of the box.

	- Parameter horizontal: The requested *x* coordinate. This parameter is required.
	- Parameter vertical: The requested *y* coordinate. This parameter is required.

	```
	let box = Box(location: Point(x: 10, y: 10),
		      size: Size(width: 10, height: 10))

	let topLeft = box[.Left, .Top] // Point(x: 10, y: 10)
	let midpoint = box[.Center, .Middle] // Point(x: 15, y: 15)
	let bottomRight = box[.Right, .Bottom] // Point(x: 20, y: 20)
	```
	*/
	subscript(horizontal: Grid.Row, vertical: Grid.Column) -> Point {
		let x: Double = {
			switch horizontal {
			case .left:
				return location.x
			case .center:
				return location.x + (size.width / 2.0)
			case .right:
				return location.x + size.width
			}
		}()

		let y: Double = {
			switch vertical {
			case .top:
				return location.y
			case .middle:
				return location.y + (size.height / 2.0)
			case .bottom:
				return location.y + size.height
			}
		}()

		return Point(x: x, y: y)
	}

	/**
	- Returns: A random coordinate within the current bounding box.
	*/
	public func randomCoordinate() -> Point {
		return Point(x: Double.random(in: 0 ... size.width), y: Double.random(in: 0 ... size.height))
	}

	/**
	Determines if a *Point* lies within a bounding box.

	- Returns: **true** or **false**.
	*/
	public func contains(_ point: Point) -> Bool {
		if point.x > size.width || point.x < 0.0 {
			return false
		}

		if point.y > size.height || point.y < 0.0 {
			return false
		}

		return true
	}
}

extension Box: CustomStringConvertible {
	public var description: String {
		return "Box(location: \(location), size: \(size))"
	}
}

extension Box: Hashable {
	public func hash(into hasher: inout Hasher) {
		hasher.combine(location)
		hasher.combine(size)
		_ = hasher.finalize()
	}
}

public func ==(x: Box, y: Box) -> Bool {
	return x.location == y.location && x.size == y.size
}

public func +(x: Box, y: Box) -> Box {
	return Box(location: x.location + y.location, size: x.size + y.size)
}

public func +(x: Box, y: Point) -> Box {
	return Box(location: x.location + y, size: x.size)
}

public func +(x: Box, y: Size) -> Box {
	return Box(location: x.location, size: x.size + y)
}

public func -(x: Box, y: Box) -> Box {
	return Box(location: x.location - y.location, size: x.size - y.size)
}

public func -(x: Box, y: Point) -> Box {
	return Box(location: x.location - y, size: x.size)
}

public func -(x: Box, y: Size) -> Box {
	return Box(location: x.location, size: x.size - y)
}

public func *(x: Box, y: Double) -> Box {
	return Box(location: x.location, size: x.size * y)
}

public func /(x: Box, y: Double) -> Box {
	return Box(location: x.location, size: x.size / y)
}

public func += (x: inout Box, y: Box) {
	x = x + y
}

public func += (x: inout Box, y: Point) {
	x = x + y
}

public func += (x: inout Box, y: Size) {
	x = x + y
}

public func -= (x: inout Box, y: Box) {
	x = x - y
}

public func -= (x: inout Box, y: Point) {
	x = x - y
}

public func -= (x: inout Box, y: Size) {
	x = x - y
}

public func *= (x: inout Box, y: Double) {
	x = x * y
}

public func /= (x: inout Box, y: Double) {
	x = x / y
}
