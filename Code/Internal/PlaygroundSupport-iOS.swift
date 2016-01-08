#if os(iOS)
import UIKit

extension Aura {

}

extension Color {
	public func debugQuickLookObject() -> AnyObject? {
		return UIColor(CGColor: CGColorView) as AnyObject?
	}
}

extension Image {
//	public func debugQuickLookObject() -> AnyObject? {
//		let data = NSData(bytes: storage, length: storage.length)
//		return UIImage(data: data, scale: 1.0)
//	}
}

extension Bezier {
	public func debugQuickLookObject() -> AnyObject? {
		return UIBezierPath(CGPath: CGPathView) as AnyObject?
	}
}
#endif
