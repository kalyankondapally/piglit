/* [config]
 * expect_result: pass
 * glsles_version: 1.00
 * [end config]
 *
 * From Section 4.19 Arrays in GLSL-ES 1.0 Spec (Page 24 of the PDF):
 *
 *     "All basic types and structures can be formed into arrays."
 */


uniform float array01[1];
uniform int array02[1];
uniform bool array03[1];
uniform vec2 array04[1];
uniform vec3 array05[1];
uniform vec4 array06[1];
uniform ivec2 array07[1];
uniform ivec3 array08[1];
uniform ivec4 array09[1];
uniform bvec2 array10[1];
uniform bvec3 array11[1];
uniform bvec4 array12[1];
uniform mat2 array13[1];
uniform mat3 array17[1];
uniform mat4 array21[1];
uniform sampler2D array26[1];
uniform samplerCube array28[1];

void main() { gl_Position = vec4(0.0); }
