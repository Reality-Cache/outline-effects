#version 150

in vec3 Position;

out vec2 texCoord;

// A full-screen quad given straight in clip space. Z is passed through so the
// composite can sit just short of the far plane and be depth-tested against the
// hand; the offscreen passes use 0 and have depth testing off.
void main() {
    gl_Position = vec4(Position, 1.0);
    texCoord = Position.xy * 0.5 + 0.5;
}
