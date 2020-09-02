varying vec2 out_uv;
varying vec3 out_color;
varying vec4 out_mask;

uniform sampler2D diffuse;

void main(void)
{
	//gl_FragColor = vec4(texture2D(diffuse, out_uv));

	float red = texture2D(diffuse, out_uv).r;

	if (red != 1.0)
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
				gl_FragColor = vec4(out_color.x, out_color.y, out_color.z, red);
				
				return;
			}
		}
	}
	else
	{
		gl_FragColor = vec4(out_color.x, out_color.y, out_color.z, red);
		
		return;
	}

	discard;

	//gl_FragColor = vec4(1, red, red, 1);
}