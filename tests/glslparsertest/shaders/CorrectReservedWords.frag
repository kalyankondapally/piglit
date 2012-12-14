// [config]
// expect_result: pass
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

uniform float MIN;
uniform float R0;
uniform float FOGC;
uniform float CUBE;
uniform float f;
uniform float o;
uniform float p;
uniform float w;
uniform float x;
uniform float y;
uniform float z;

void main()
{
	gl_FragColor = vec4(f, o, p, w);
}
