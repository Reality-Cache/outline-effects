#version 150

uniform sampler2D Sampler0;
uniform float AlphaCutoff;

in vec4 vertexColor;
in vec2 texCoord0;

out vec4 fragColor;

// Only the texture's ALPHA is read, to cut the same shape the item itself is cut
// to; the colour that comes out is the flat tint. The cutoff has to match the
// item's own layer (rendertype_entity_translucent_cull uses 0.1) or the outline
// would be a slightly different shape from the thing it outlines.
void main() {
    if (texture(Sampler0, texCoord0).a < AlphaCutoff) {
        discard;
    }
    fragColor = vertexColor;
}
