// [config]
// expect_result: pass
// glsles_expect_result: fail
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

uniform sampler2DRect samp;

void main()
{
	gl_FragColor = texture2DRect(samp, vec2(0.0, 0.0));
}
