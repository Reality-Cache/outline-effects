#version 150

uniform sampler2D Sampler0;

in vec4 vertexColor;
in vec2 texCoord0;

out vec4 fragColor;

// Unlike the outline, a rune KEEPS the texture's alpha rather than cutting on
// it: the glyph's shape lives in that alpha, and the vertex alpha is the blink,
// so the two multiply together. The colour is the vertex's own — the font sheet
// is white, so whatever tint comes down the vertex is what shows.
void main() {
    float shape = texture(Sampler0, texCoord0).a;
    if (shape < 0.01) {
        discard;
    }
    fragColor = vec4(vertexColor.rgb, vertexColor.a * shape);
}
