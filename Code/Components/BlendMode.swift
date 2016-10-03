// todo: when writing docs, reference images in the playground, provide examples of all of the blend modes being applied
/**
A list of common blend modes that renderers can support. See [here](https://en.wikipedia.org/wiki/Blend_modes) for discussions on blend modes. The default *BlendMode* is *.Normal*.
*/
public enum BlendMode {
	case normal
	case multiply
	case screen
	case overlay
	case darken
	case lighten
	case colorDodge
	case colorBurn
	case softLight
	case hardLight
	case difference
	case exclusion
	case hue
	case saturation
	case color
	case luminosity
}
