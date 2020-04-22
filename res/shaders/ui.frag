uniform sampler2D diffuse;

varying vec2 out_uv;

void main(void) 
{
	vec4 _color = texture2D(diffuse, out_uv.xy); 
	
	if (_color.w == 0.0)
	{
		discard;
	}

	gl_FragColor = _color;	
}

// Fragment shader unspoken rules!
//
// 1: Beware of reserved keywords. May cause unpredictable bugs.