// [config]
// expect_result: fail
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

#pragma debug(on)
#version 110  // error #version should be the first statement in the program


void main()
{
   gl_FragColor = vec4(1);    
}
