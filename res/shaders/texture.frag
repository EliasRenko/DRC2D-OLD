varying vec2 out_uv;

uniform sampler2D diffuse;

void main(void)
{
	//gl_FragColor = texture2D(diffuse, out_uv);

	gl_FragColor = vec4(0.5333, 0.0824, 0.5333, 1.0);
}