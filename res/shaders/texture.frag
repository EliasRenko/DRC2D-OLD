varying vec2 out_uv;

uniform sampler2D diffuse;

void main(void)
{
	gl_FragColor = texture2D(diffuse, out_uv);
}