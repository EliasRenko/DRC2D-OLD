attribute vec3 aPosition;
attribute vec2 uv;

varying vec2 out_uv;

uniform mat4 uMatrix;
uniform mat4 modelview;

void main(void)
{
	gl_Position = uMatrix * modelview * vec4(aPosition, 1.0);

	uv_out = uv;
}