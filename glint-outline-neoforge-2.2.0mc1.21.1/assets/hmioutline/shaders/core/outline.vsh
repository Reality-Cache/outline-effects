#version 150

in vec3 Position;
in vec4 Color;
in vec2 UV0;
in ivec2 UV2;
in vec3 Normal;

uniform mat4 ModelViewMat;
uniform mat4 ProjMat;

out vec4 vertexColor;
out vec2 texCoord0;

// The outline is real geometry: a copy of the item's own quads, grown inside the
// plane of each quad and turned inside out, drawn behind the item. Nothing here
// needs lighting or fog — the band is a flat colour — so the vertex only carries
// the tint through and the texture coordinate the shape is cut from.
void main() {
    gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);
    vertexColor = Color;
    texCoord0 = UV0;
}
