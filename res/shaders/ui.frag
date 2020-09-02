uniform sampler2D diffuse;

varying vec2 out_uv;
varying vec3 out_color;
varying vec4 out_mask;

void main(void) 
{
	vec4 _color = texture2D(diffuse, out_uv.xy); 
	
	if (_color.w == 0.0)
	{
		discard;
	}

	float stx = gl_FragCoord.x / 640.0;
	float sty = gl_FragCoord.y / 480.0;
 
	if (out_mask.z != 1.0)
	{
		if (stx > out_mask.x && stx < out_mask.z + out_mask.x)
		{
			if (sty < 1.0 - out_mask.y && sty > 1.0 - (out_mask.w + out_mask.y))
			{
				gl_FragColor = vec4(_color.rgb * out_color, _color.a);
				
				return;
			}
		}
	}
	else
	{
		gl_FragColor = vec4(_color.rgb * out_color, _color.a);
		
		return;
	}

	discard;
}

// Fragment shader unspoken rules!
//
// 1: Beware of reserved keywords. May cause unpredictable bugs.