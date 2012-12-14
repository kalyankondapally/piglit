// [config]
// expect_result: pass
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

/* PASS */
uniform int count;
uniform vec4 data[10];

void main()
{
  vec4 value = vec4(0.0);

  for (int i = 0; i < count; i++) {
    value += data[i];
  }

  gl_Position = value;
}
