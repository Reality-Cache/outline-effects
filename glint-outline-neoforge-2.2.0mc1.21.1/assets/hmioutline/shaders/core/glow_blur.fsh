#version 150

uniform sampler2D Sampler0;
uniform vec2 Texel;       // one texel of the source
uniform vec2 Direction;   // (1,0) or (0,1)
uniform float Spread;     // texels between taps

in vec2 texCoord;

out vec4 fragColor;

// One direction of a separable Gaussian: 13 taps, sigma of 3 taps. The source
// is filtered linearly, so spacing the taps out widens the blur without the
// gaps between them showing, as long as a second round follows.
void main() {
    const float weights[7] = float[](0.1370, 0.1296, 0.1097, 0.0831, 0.0563, 0.0342, 0.0185);
    vec2 step = Direction * Texel * Spread;
    vec4 sum = texture(Sampler0, texCoord) * weights[0];
    for (int i = 1; i < 7; i++) {
        sum += texture(Sampler0, texCoord + step * float(i)) * weights[i];
        sum += texture(Sampler0, texCoord - step * float(i)) * weights[i];
    }
    fragColor = sum;
}
