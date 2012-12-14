// [config]
// expect_result: fail
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

/* FAIL - structure name conflicts with another structure */

struct foo {
  float x;
  int y;
  bool z;
};

struct foo {
  float f;
  int i;
  bool b;
};
