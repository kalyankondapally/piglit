// [config]
// expect_result: fail
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

/* FAIL - arrays passed as parameters must declare a size */
void func(in vec4 vertices[])
{
    gl_Position = gl_Vertex;
}
