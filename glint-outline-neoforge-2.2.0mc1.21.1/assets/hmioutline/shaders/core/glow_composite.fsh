#version 150

uniform sampler2D Sampler0;   // the narrow glow, a quarter of the screen's size
uniform sampler2D Sampler1;   // the wide glow, same size
uniform vec2 Weights;         // how much of each

in vec2 texCoord;

out vec4 fragColor;

// The halo was drawn premultiplied onto black, so its colour is already its
// strength. Where it would run past full brightness it is scaled down as a
// whole rather than clipped per channel: clipping each channel at 1 turns every
// bright colour white at the core, and the halo is meant to stay the item's
// colour all the way in.
//
// Blended as a screen (ONE, ONE_MINUS_SRC_COLOR): dark ground lights up by the
// full amount, bright ground less, and nothing burns past white.
void main() {
    vec3 glow = texture(Sampler0, texCoord).rgb * Weights.x
              + texture(Sampler1, texCoord).rgb * Weights.y;
    float peak = max(glow.r, max(glow.g, glow.b));
    if (peak > 1.0) {
        glow /= peak;
    }
    fragColor = vec4(glow, 1.0);
}
