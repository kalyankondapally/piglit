// [config]
// expect_result: pass
// glsl_version: 1.10
// glsles_version: 1.00
// glsles_expect_result: pass
// [end config]

/* PASS */
void func(in vec4 vertices[12])
{
    gl_Position = vertices[0];
}
