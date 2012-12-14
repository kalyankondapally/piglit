// [config]
// expect_result: fail
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

/* Only one version statement is allowed; two should raise an error. */
#version 100
#version 100

void main()
{
   gl_FragColor = vec4(1);
}
