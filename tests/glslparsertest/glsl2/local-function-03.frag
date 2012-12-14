// [config]
// expect_result: pass
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

/* PASS - local function declarations are not allowed in GLSL 1.10. */
#ifndef GL_ES
#version 110
#endif
void main() {
    float foo(float x);
    gl_FragColor = vec4(0.0, foo(0.5), 0.0, 1.0);
}

float foo(float x) {
    return x + 0.5;
}

