// [config]
// expect_result: pass
// glsl_version: 1.30
// [end config]
//
// Function parameters and return types can have precision qualifiers.
//
// From section 4.5.2 of the GLSL 1.30 spec:
//     Any floating point or any integer declaration can have the type
//     preceded by one of these precision qualifiers

#version 130

highp float f(lowp int x) {
	return 0.0;
}
