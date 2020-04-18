attribute vec3 aPosition;

uniform mat4 uMatrix;
uniform mat4 modelview;

void main(void)
{
	gl_Position = uMatrix * modelview * vec4(aPosition, 1.0);
}