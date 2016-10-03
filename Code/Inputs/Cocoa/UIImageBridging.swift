import ImageIO
import MobileCoreServices
import UIKit

extension UIImage: ImageViewable {
	public var bitmapView: UnsafePointer<UInt8> {
		get {
			return cgImage!.bitmapView
		}
	}

	public var JPEGView: UnsafePointer<UInt8> {
		get {
			return (UIImageJPEGRepresentation(self, 1.0)! as NSData).bytes.bindMemory(to: UInt8.self, capacity: UIImageJPEGRepresentation(self, 1.0)!.count)
		}
	}

	public var PNGView: UnsafePointer<UInt8> {
		get {
			return (UIImagePNGRepresentation(self)! as NSData).bytes.bindMemory(to: UInt8.self, capacity: UIImagePNGRepresentation(self)!.count)
		}
	}
}

extension Image {
	public init(image: UIImage) {
		self.init(data: image.bitmapView, size: Size(size: image.size))
	}
}

