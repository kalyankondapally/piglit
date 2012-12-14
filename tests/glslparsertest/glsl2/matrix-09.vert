// [config]
// expect_result: fail
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

/* FAIL - matrix-to-matrix constructors are not available in GLSL 1.10 */

uniform mat3 a;

void main()
{
    mat2 m;

    m = mat2(a);
    gl_Position = gl_Vertex;
}
