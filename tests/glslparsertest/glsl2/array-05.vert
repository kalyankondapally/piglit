// [config]
// expect_result: fail
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

/* FAIL - array size type must be scalar */
uniform vec4 a[ivec4(3)];
