// [config]
// expect_result: pass
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

/* PASS */
void main()
{
	float a;
	vec4 b;

	b.x = 6.0;
	a = b.x;
}
