import CoreGraphics
import ImageIO
import AppKit

extension NSImage: ImageViewable {
	private func representation(type: NSBitmapImageFileType) -> UnsafePointer<UInt8> {
		let representation = representations.first as! NSBitmapImageRep
		let data = representation.representationUsingType(type, properties: [:])!
		return UnsafePointer<UInt8>(data.bytes)
	}

	public var bitmapView: UnsafePointer<UInt8> {
		return representation(.NSBMPFileType)
	}

	public var JPEGView: UnsafePointer<UInt8> {
		return representation(.NSJPEGFileType)
	}

	public var PNGView: UnsafePointer<UInt8> {
		return representation(.NSPNGFileType)
	}
}

extension Image {
	public init(image: NSImage) {
		self.init(data: image.bitmapView, size: Size(size: image.size))
	}
}

