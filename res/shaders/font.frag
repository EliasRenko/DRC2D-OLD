varying vec2 out_uv;

uniform sampler2D diffuse;

void main(void)
{
	//gl_FragColor = vec4(texture2D(diffuse, out_uv));

	gl_FragColor = vec4(1.0, 1.0, 1.0, texture2D(diffuse, out_uv).r);
}