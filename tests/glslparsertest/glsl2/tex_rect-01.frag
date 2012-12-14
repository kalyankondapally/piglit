// [config]
// expect_result: pass
// glsles_expect_result: fail
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

/* PASS */

uniform sampler2DRect s;

void main()
{
  gl_FragColor = vec4(1.0, 1.0, 1.0, 1.0);
}
