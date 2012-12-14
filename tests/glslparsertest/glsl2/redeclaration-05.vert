// [config]
// expect_result: fail
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

/* FAIL - variable redeclared */
void main()
{
    float foo;
    float foo;
    gl_Position = vec4(0.0);
}

