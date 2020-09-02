attribute vec3 location;
attribute vec2 uv;

varying vec2 out_uv;

uniform mat4 matrix;

void main(void) {
		
	out_uv = uv;

	gl_Position = matrix * vec4(location.xyz, 1);
}