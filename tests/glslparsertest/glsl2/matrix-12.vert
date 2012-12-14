// [config]
// expect_result: pass
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

/* PASS */

uniform mat4 a;

void main()
{
    gl_Position = vec4(a[1][0]);
}
