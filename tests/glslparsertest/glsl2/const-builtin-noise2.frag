// [config]
// expect_result: fail
// glsl_version: 1.20
// glsles_version: 1.00
//
// [end config]

/* FAIL - noise functions are not allowed in constant expressions */
#version 120
void main() {
   const vec2 noise = noise2(0.5);
}
