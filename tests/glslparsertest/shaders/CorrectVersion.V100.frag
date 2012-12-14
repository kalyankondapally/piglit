// [config]
// expect_result: pass
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

/* #version can only be followed by number 100. The only statements before
   #version can be comment or white spaces */



#version 100


void main()
{
   gl_FragColor = vec4(1);
}
