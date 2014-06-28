// [config]
// expect_result: fail
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

/* FAIL */
#if defined GL_ARB_texture_rectangle
#extension GL_ARB_texture_rectangle: disable
#endif

uniform sampler2DRect s;
