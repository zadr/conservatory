import CoreGraphics
import ImageIO
import AppKit

extension NSImage: ImageViewable {
	private func representation(type: NSBitmapImageFileType) -> UnsafePointer<UInt8> {
		let representation = representations.first as! NSBitmapImageRep
		let data = representation.representation(using: type, properties: [:])!
		return data.bytes.bindMemory(to: UInt8.self, capacity: data.length)
		return UnsafePointer<UInt8>(data.bytes)
	}

	public var bitmapView: UnsafePointer<UInt8> {
		return representation(type: .BMP)
	}

	public var JPEGView: UnsafePointer<UInt8> {
		return representation(type: .JPEG)
	}

	public var PNGView: UnsafePointer<UInt8> {
		return representation(type: .PNG)
	}
}

extension Image {
	public init(image: NSImage) {
		self.init(data: image.bitmapView, size: Size(size: image.size))
	}
}

