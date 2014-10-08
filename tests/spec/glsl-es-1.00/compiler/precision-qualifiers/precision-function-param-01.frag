// [config]
// expect_result: pass
// glsl_version: 1.00
// [end config]
//
// Function parameters and return types can have precision qualifiers.
//
// From section 4.5.2 of the GLSL 1.00 spec:
//     Any floating point or any integer declaration can have the type
//     preceded by one of these precision qualifiers

#version 100

void f(lowp int x) { }

void main() { }