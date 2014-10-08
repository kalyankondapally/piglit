// [config]
// expect_result: fail
// glsl_version: 1.00
// [end config]
//
// From section 7.2 of the GLSL ES 1.00 spec:
//     The fragment shader has access to the read-only built-in variable
//     gl_PointCoord. The values in gl_PointCoord are two-dimensional
//     coordinates indicating where within a point primitive the current
//     fragment is located. They range from 0.0 to 1.0 across the point. This
//     is described in more detail in Section 3.3.1 Basic Point Rasterization
//     of version 2.0 of the OpenGL specification, where point sprites are
//     discussed. If the current primitive is not a point, then the values read
//     from gl_PointCoord are undefined.

#version 100

void main() {
    gl_PointCoord = vec2(0.0);
}
