// [config]
// expect_result: pass
// glsles_expect_result: fail
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

/* PASS */
void main()
{
    mat4  result;
    result = gl_TextureMatrix[0];
    result = gl_TextureMatrixInverse[0];
    result = gl_TextureMatrixTranspose[0];
    result = gl_TextureMatrixInverseTranspose[0];
}
