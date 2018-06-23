import ImageIO
import MobileCoreServices
import UIKit

extension UIImage: ImageViewable {
	public var bitmapView: UnsafePointer<UInt8> {
		return cgImage!.bitmapView
	}

	public var JPEGView: UnsafePointer<UInt8> {
		return (pngData()! as NSData).bytes.bindMemory(to: UInt8.self, capacity: jpegData(compressionQuality: 1.0)!.count)
	}

	public var PNGView: UnsafePointer<UInt8> {
		return (pngData()! as NSData).bytes.bindMemory(to: UInt8.self, capacity: pngData()!.count)
	}
}

extension Image {
	public init(image: UIImage) {
		self.init(data: image.bitmapView, size: Size(size: image.size))
	}
}

