#version 150

uniform sampler2D Sampler0;
uniform vec2 Texel;   // one texel of the SOURCE (the full-size mask)

in vec2 texCoord;

out vec4 fragColor;

// A 4x4 box average for a 4x shrink: four bilinear taps, each landing on the
// corner shared by four source texels, cover all sixteen. A plain resize would
// sample one texel in sixteen and lose a one-pixel band to aliasing.
void main() {
    fragColor = 0.25 * (texture(Sampler0, texCoord + Texel * vec2(-1.0, -1.0))
                      + texture(Sampler0, texCoord + Texel * vec2( 1.0, -1.0))
                      + texture(Sampler0, texCoord + Texel * vec2(-1.0,  1.0))
                      + texture(Sampler0, texCoord + Texel * vec2( 1.0,  1.0)));
}
