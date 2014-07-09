# -*- coding: utf-8 -*-
# All tests that come with piglit, using default settings
#
__all__ = ['profile']

import itertools
import os
import platform
import subprocess
import sys

from framework.profile import TestProfile
from framework.exectest import PiglitTest
from framework.gleantest import GleanTest
from framework.glsl_parser_test import GLSLParserTest, add_glsl_parser_test, import_glsl_parser_tests
from framework.shader_test import add_shader_test_dir

# Path to tests dir, correct even when not running from the top directory.
testsDir = os.path.dirname(__file__)
if sys.platform == "cygwin":
    # convert the path to DOS style so it's parsable by shader_runner, etc.
    testsDir = subprocess.check_output(['cygpath', '-d', testsDir]).rstrip()

# Find the generated_tests directory, by looking either in
# $PIGLIT_BUILD_DIR (if that environment variable exists) or in the
# parent directory of the directory containing this file.
generatedTestDir = os.path.normpath(os.path.join(
    os.environ.get('PIGLIT_BUILD_DIR', os.path.join(testsDir, '..')),
    'generated_tests'))

# Quick wrapper for PiglitTest for our usual concurrent args.
def plain_test(args):
    return PiglitTest(args.split() + ['-auto'])

def add_single_param_test_set(group, name, *params):
    for param in params:
        group[name + '-' + param] = plain_test(name + ' ' + param)

def add_plain_test(group, args):
    group[args] = plain_test(args)

def concurrent_test(args):
    test = plain_test(args + ' -fbo')
    test.run_concurrent = True
    return test

def add_concurrent_test(group, args):
    group[args] = concurrent_test(args)

# Generate all possible subsets of the given set, including the empty set.
def power_set(s):
    if len(s) == 0:
        return [[]]
    result = []
    for p in power_set(s[:-1]):
        result.append(p)
        result.append(p + [s[-1]])
    return result

######
# Collecting all tests
profile = TestProfile()

spec = {}

gles20 = {}
spec['!OpenGL ES 2.0'] = gles20
gles20['glsl-fs-pointcoord'] = concurrent_test('glsl-fs-pointcoord_gles2')
add_concurrent_test(gles20, 'invalid-es3-queries_gles2')
gles20['link-no-vsfs'] = concurrent_test('link-no-vsfs_gles2')
add_concurrent_test(gles20, 'minmax_gles2')
add_concurrent_test(gles20, 'multiple-shader-objects_gles2')
add_concurrent_test(gles20, 'fbo_discard_gles2')

profile.tests['spec'] = spec
