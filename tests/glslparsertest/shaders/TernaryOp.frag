// [config]
// expect_result: fail
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

void main()
{
    mat4 m;
    vec4 v;
    bool b;
    gl_FragColor = b ? v : m; 
}
