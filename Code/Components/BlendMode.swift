// todo: when swift docs can reference images in the playground, provide examples of all of the blend modes being applied
/**
A list of common blend modes that renderers can support. See [here](https://en.wikipedia.org/wiki/Blend_modes) for discussions on blend modes. The default *BlendMode* is *.Normal*.
*/
public enum BlendMode {
	case Normal
	case Multiply
	case Screen
	case Overlay
	case Darken
	case Lighten
	case ColorDodge
	case ColorBurn
	case SoftLight
	case HardLight
	case Difference
	case Exclusion
	case Hue
	case Saturation
	case Color
	case Luminosity
}
