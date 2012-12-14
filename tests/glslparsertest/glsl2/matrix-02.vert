// [config]
// expect_result: fail
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

/* FAIL - non-square matrices are not available in GLSL 1.10 */

void main()
{
    mat2x4 m;
}
