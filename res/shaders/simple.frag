varying vec2 out_uv;

uniform sampler2D uImage0;

void main(void)
{
	gl_FragColor = texture2D(uImage0, out_uv);
}