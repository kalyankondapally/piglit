// [config]
// expect_result: pass
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

#ifndef GL_ES
#version 110
#else
#version 100
#endif

#extension extensionfoo : enable  // warning extension not supported
#extension extensionfoo : disable  // warning extension not supported
#extension extensionfoo : warn  // warning extension not supported

#extension all : disable // no error in the program
#extension all : warn // no error in the program

#extension extensionfoo : enable  // warning extension not supported
#extension extensionfoo : disable  // warning extension not supported
#extension extensionfoo : warn  // warning extension not supported

void main()
{
}
