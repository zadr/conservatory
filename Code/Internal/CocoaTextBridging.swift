import CoreText
import Foundation

#if os(OSX)
	import AppKit
#elseif os(iOS)
	import UIKit
#endif

internal extension String {
	internal func cocoaValue(_ effects: [TextEffect]) -> NSAttributedString {
		let result = NSMutableAttributedString(string: self)
		for effect in effects {
			var fontDescriptor = CTFontDescriptorCreateWithNameAndSize(effect.font.name as CFString, CGFloat(effect.font.size))
			if effect.bold {
				var attribute: Int = 0
				if let copiedAttribute = CTFontDescriptorCopyAttribute(fontDescriptor, kCTFontSymbolicTrait) {
					attribute = copiedAttribute as! Int
				}

				fontDescriptor = CTFontDescriptorCreateCopyWithAttributes(fontDescriptor, [
					String(kCTFontSymbolicTrait): Int(attribute | Int(CTFontSymbolicTraits.boldTrait.rawValue))
				] as CFDictionary)
			}

			if effect.italic {
				var attribute: Int = 0
				if let copiedAttribute = CTFontDescriptorCopyAttribute(fontDescriptor, kCTFontSymbolicTrait) {
					attribute = copiedAttribute as! Int
				}

				fontDescriptor = CTFontDescriptorCreateCopyWithAttributes(fontDescriptor, [
					String(kCTFontSymbolicTrait): Int(attribute | Int(CTFontSymbolicTraits.italicTrait.rawValue))
				] as CFDictionary)
			}

			var attributes: [NSAttributedString.Key: Any] = [
				NSAttributedString.Key(String(kCTFontAttributeName)): CTFontCreateWithFontDescriptor(fontDescriptor, CGFloat(effect.font.size), nil),
				NSAttributedString.Key(String(kCTLigatureAttributeName)): effect.ligature,
				NSAttributedString.Key(String(kCTKernAttributeName)): effect.kerning
			]

			if effect.underline != .none {
				attributes[NSAttributedString.Key(String(kCTUnderlineStyleAttributeName))] = Int(effect.underline.coreTextView)
			}
/*
			if $0.strikethrough != .None {
				attributes[NSStrikethroughStyleAttributeName] = $0.strikethrough.cocoaValue
			}

			if $0.aura.shouldApplyAura {
				attributes[NSShadowAttributeName] = $0.aura.cocoaValue
			}
*/

			for (key, value) in effect.metadata {
				attributes[NSAttributedString.Key(key)] = value
			}

			result.addAttributes(attributes, range: toNSRange(effect.range))
		}

		return result
	}

	fileprivate func toNSRange(_ range: Range<String.Index>) -> NSRange {
		let start = distance(from: startIndex, to: range.lowerBound)
		let length = distance(from: range.lowerBound, to: range.upperBound)
		return NSMakeRange(start, length)
	}
}

// MARK: -

#if os(OSX)
fileprivate extension Aura {
	fileprivate var cocoaValue: NSShadow {
		let shadow = NSShadow()
		shadow.shadowOffset = CGSize(width: offset.width, height: offset.height)
		shadow.shadowColor = color.cocoaValue
		shadow.shadowBlurRadius = CGFloat(blur)
		return shadow
	}
}

fileprivate extension Color {
	fileprivate var cocoaValue: NSColor {
		let rgb = RGBView
		return NSColor(red: CGFloat(rgb.red), green: CGFloat(rgb.green), blue: CGFloat(rgb.blue), alpha: CGFloat(AView))
	}
}
#elseif os(iOS)
fileprivate extension Color {
	fileprivate var cocoaValue: UIColor {
		let rgb = RGBView
		return UIColor(red: CGFloat(rgb.red), green: CGFloat(rgb.green), blue: CGFloat(rgb.blue), alpha: CGFloat(AView))
	}
}
#endif

fileprivate extension LinePattern {
	var coreTextView: Int32 {
		switch self {
		case .none:
			return CTUnderlineStyle().rawValue
		case .single:
			return CTUnderlineStyle.single.rawValue
		case .thick:
			return CTUnderlineStyle.thick.rawValue
		case .double:
			return CTUnderlineStyle.double.rawValue
		case .dotted:
			return CTUnderlineStyle.single.rawValue | CTUnderlineStyleModifiers.patternDot.rawValue
		case .dashed:
			return CTUnderlineStyle.single.rawValue | CTUnderlineStyleModifiers.patternDash.rawValue
		case .dashedAndDotted:
			return CTUnderlineStyle.single.rawValue | CTUnderlineStyleModifiers.patternDashDot.rawValue
		case .dashedAndDottedTwice:
			return CTUnderlineStyle.single.rawValue | CTUnderlineStyleModifiers.patternDashDotDot.rawValue
		}
	}
}
