varying vec2 out_uv;

float checkerboard(in vec2 uv)
{
    vec2 pos = floor(uv * 0.032);

  	return mod(pos.x + mod(pos.y, 2.0), 2.0);
}

void main(void)
{
	vec2 uv = gl_FragCoord.xy;

	float p = checkerboard(uv);

	gl_FragColor = vec4(p, p, p, 1.0);
}