# -*- coding: utf-8 -*-
# All GLES tests that come with piglit, using default settings
#
__all__ = ['profile']

import itertools
import os
import os.path as path
import platform
import shlex

from framework.profile import TestProfile
from framework.exectest import PiglitTest
from framework.glsl_parser_test import GLSLESParserTest, add_glsl_es_parser_test
from framework.shader_test import add_shader_test, add_shader_test_dir
# ShaderTest, ShaderES2Test

# Path to tests dir, correct even when not running from the top directory.
testsDir = path.dirname(__file__)

# Find the generated_tests directory, by looking either in
# $PIGLIT_BUILD_DIR (if that environment variable exists) or in the
# parent directory of the directory containing this file.
generatedTestDir = path.normpath(path.join(
    os.environ.get('PIGLIT_BUILD_DIR',
                   path.join(testsDir, '..')),
                   'generated_tests'))

# Quick wrapper for PiglitTest for our usual concurrent args.
def plain_test(args):
    return PiglitTest(shlex.split(args) + ['-auto'])

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

# Group KHR_debug
khr_debug = {}
spec['KHR_debug'] = khr_debug
khr_debug['object-label_gl'] = concurrent_test('khr_debug-object-label_gl')
khr_debug['object-label_gles2'] = concurrent_test('khr_debug-object-label_gles2')
khr_debug['object-label_gles3'] = concurrent_test('khr_debug-object-label_gles3')
khr_debug['push-pop-group_gl'] = concurrent_test('khr_debug-push-pop-group_gl')
khr_debug['push-pop-group_gles2'] = concurrent_test('khr_debug-push-pop-group_gles2')
khr_debug['push-pop-group_gles3'] = concurrent_test('khr_debug-push-pop-group_gles3')

oes_packed_depth_stencil = {}
spec['OES_packed_depth_stencil'] = oes_packed_depth_stencil
oes_packed_depth_stencil['DEPTH_STENCIL texture GLES2'] = concurrent_test('oes_packed_depth_stencil-depth-stencil-texture_gles2')
oes_packed_depth_stencil['DEPTH_STENCIL texture GLES1'] = concurrent_test('oes_packed_depth_stencil-depth-stencil-texture_gles1')


arb_transform_feedback2 = {}
spec['ARB_transform_feedback2'] = arb_transform_feedback2
arb_transform_feedback2['Change objects while paused'] = PiglitTest(['arb_transform_feedback2-change-objects-while-paused', '-auto'])
arb_transform_feedback2['Change objects while paused (GLES3)'] = PiglitTest(['arb_transform_feedback2-change-objects-while-paused_gles3', '-auto'])
arb_transform_feedback2['draw-auto'] = PiglitTest(['arb_transform_feedback2-draw-auto', '-auto'])
arb_transform_feedback2['istranformfeedback'] = PiglitTest(['arb_transform_feedback2-istransformfeedback', '-auto'])
arb_transform_feedback2['glGenTransformFeedbacks names only'] = concurrent_test('arb_transform_feedback2-gen-names-only')
arb_transform_feedback2['cannot bind when another object is active'] = concurrent_test('arb_transform_feedback2-cannot-bind-when-active')
arb_transform_feedback2['misc. API queries'] = concurrent_test('arb_transform_feedback2-api-queries')
arb_transform_feedback2['counting with pause'] = concurrent_test('arb_transform_feedback2-pause-counting')

glslparser = {}
spec['!glsl es 1.0 parser'] = glslparser
# Add all shader source files in the directories below for gles20
for filename in os.listdir(testsDir + '/glslparsertest/shaders'):
	ext = filename.rsplit('.')[-1]
	if ext in ['vert', 'geo', 'frag']:
		add_glsl_es_parser_test(glslparser, path.join(testsDir, 'glslparsertest/shaders', filename), filename)

for filename in os.listdir(testsDir + '/glslparsertest/glsl2'):
	ext = filename.rsplit('.')[-1]
	if ext in ['vert', 'geo', 'frag']:
		add_glsl_es_parser_test(glslparser, path.join(testsDir, 'glslparsertest/glsl2', filename), 'glsl2/' + filename)

for filename in os.listdir(testsDir + '/spec/glsl-es-1.00/compiler/arithmetic-operators'):
	ext = filename.rsplit('.')[-1]
	if ext in ['vert', 'geo', 'frag']:
		add_glsl_es_parser_test(glslparser, path.join(testsDir, 'spec/glsl-es-1.00/compiler/arithmetic-operators', filename), filename)
for filename in os.listdir(testsDir + '/spec/glsl-es-1.00/compiler/assignment-operators'):
	ext = filename.rsplit('.')[-1]
	if ext in ['vert', 'geo', 'frag']:
		add_glsl_es_parser_test(glslparser, path.join(testsDir, 'spec/glsl-es-1.00/compiler/assignment-operators', filename), filename)
for filename in os.listdir(testsDir + '/spec/glsl-es-1.00/compiler/built-in-functions'):
	ext = filename.rsplit('.')[-1]
	if ext in ['vert', 'geo', 'frag']:
		add_glsl_es_parser_test(glslparser, path.join(testsDir, 'spec/glsl-es-1.00/compiler/built-in-functions', filename), filename)
for filename in os.listdir(testsDir + '/spec/glsl-es-1.00/compiler/clipping'):
	ext = filename.rsplit('.')[-1]
	if ext in ['vert', 'geo', 'frag']:
		add_glsl_es_parser_test(glslparser, path.join(testsDir, 'spec/glsl-es-1.00/compiler/clipping', filename), filename)
for filename in os.listdir(testsDir + '/spec/glsl-es-1.00/compiler/qualifiers'):
	ext = filename.rsplit('.')[-1]
	if ext in ['vert', 'geo', 'frag']:
		add_glsl_es_parser_test(glslparser, path.join(testsDir, 'spec/glsl-es-1.00/compiler/qualifiers', filename), filename)
for filename in os.listdir(testsDir + '/spec/glsl-es-1.00/compiler/storage-qualifiers'):
	ext = filename.rsplit('.')[-1]
	if ext in ['vert', 'geo', 'frag']:
		add_glsl_es_parser_test(glslparser, path.join(testsDir, 'spec/glsl-es-1.00/compiler/storage-qualifiers', filename), filename)
for filename in os.listdir(testsDir + '/spec/glsl-es-1.00/compiler/structure-and-array-operations'):
	ext = filename.rsplit('.')[-1]
	if ext in ['vert', 'geo', 'frag']:
		add_glsl_es_parser_test(glslparser, path.join(testsDir, 'spec/glsl-es-1.00/compiler/structure-and-array-operations', filename), filename)

shader = {}
spec['!glsl es 1.0 shader'] = shader
add_shader_test_dir(shader, os.path.join(testsDir, 'spec', 'glsl-es-1.00','execution'), recursive=True)
add_shader_test_dir(shader, os.path.join(generatedTestDir, 'spec', 'glsl-es-1.00','execution'), recursive=True)

#glsl-es-1.00/compiler/arithmetic-operators/
#add_shader_es2_test_dir(shader, os.path.join(testsDir, 'shaders'), recursive=True)
#add_shader_es2_test_dir(shader, os.path.join(testsDir, 'spec', 'glsl-1.10', 'execution'), recursive=True)
#add_shader_es2_test_dir(shader, os.path.join(testsDir, 'spec', 'glsl-1.20', 'execution'), recursive=True)
#import_glsl_parser_tests(profile.tests, generatedTestDir, ['gles20'])

egl14 = {}
spec['EGL 1.4'] = egl14
egl14['eglCreateSurface'] = plain_test('egl-create-surface')
egl14['eglQuerySurface EGL_BAD_ATTRIBUTE'] = plain_test('egl-query-surface --bad-attr')
egl14['eglQuerySurface EGL_BAD_SURFACE'] = plain_test('egl-query-surface --bad-surface')
egl14['eglQuerySurface EGL_HEIGHT'] = plain_test('egl-query-surface --attr=EGL_HEIGHT')
egl14['eglQuerySurface EGL_WIDTH'] = plain_test('egl-query-surface --attr=EGL_WIDTH')
egl14['eglTerminate then unbind context'] = plain_test('egl-terminate-then-unbind-context')

egl_nok_swap_region = {}
spec['EGL_NOK_swap_region'] = egl_nok_swap_region
egl_nok_swap_region['basic']  = plain_test('egl-nok-swap-region')

egl_nok_texture_from_pixmap = {}
spec['EGL_NOK_texture_from_pixmap'] = egl_nok_texture_from_pixmap
egl_nok_texture_from_pixmap['basic'] = plain_test('egl-nok-texture-from-pixmap')

egl_khr_create_context = {};
spec['EGL_KHR_create_context'] = egl_khr_create_context
egl_khr_create_context['default major version GLES'] = plain_test('egl-create-context-default-major-version-gles')
egl_khr_create_context['default major version GL'] = plain_test('egl-create-context-default-major-version-gl')
egl_khr_create_context['default minor version GLES'] = plain_test('egl-create-context-default-minor-version-gles')
egl_khr_create_context['default minor version GL'] = plain_test('egl-create-context-default-minor-version-gl')
egl_khr_create_context['valid attribute empty GLES'] = plain_test('egl-create-context-valid-attribute-empty-gles')
egl_khr_create_context['valid attribute empty GL'] = plain_test('egl-create-context-valid-attribute-empty-gl')
egl_khr_create_context['NULL valid attribute GLES'] = plain_test('egl-create-context-valid-attribute-null-gles')
egl_khr_create_context['NULL valid attribute GL'] = plain_test('egl-create-context-valid-attribute-null-gl')
egl_khr_create_context['invalid OpenGL version'] = plain_test('egl-create-context-invalid-gl-version')
egl_khr_create_context['invalid attribute GLES'] = plain_test('egl-create-context-invalid-attribute-gles')
egl_khr_create_context['invalid attribute GL'] = plain_test('egl-create-context-invalid-attribute-gl')
egl_khr_create_context['invalid flag GLES'] = plain_test('egl-create-context-invalid-flag-gles')
egl_khr_create_context['invalid flag GL'] = plain_test('egl-create-context-invalid-flag-gl')
egl_khr_create_context['valid forward-compatible flag GL'] = plain_test('egl-create-context-valid-flag-forward-compatible-gl')
egl_khr_create_context['invalid profile'] = plain_test('egl-create-context-invalid-profile')
egl_khr_create_context['3.2 core profile required'] = plain_test('egl-create-context-core-profile')
egl_khr_create_context['pre-GL3.2 profile'] = plain_test('egl-create-context-pre-GL32-profile')
egl_khr_create_context['verify GL flavor'] = plain_test('egl-create-context-verify-gl-flavor')
egl_khr_create_context['valid debug flag GL'] = plain_test('egl-create-context-valid-flag-debug-gl gl')
for api in ('gles1', 'gles2', 'gles3'):
    egl_khr_create_context['valid debug flag ' + api] = plain_test('egl-create-context-valid-flag-debug-gles ' + api)

egl_ext_client_extensions = {}
spec['EGL_EXT_client_extensions'] = egl_ext_client_extensions
for i in [1, 2, 3]:
    egl_ext_client_extensions['conformance test {0}'.format(i)] = concurrent_test('egl_ext_client_extensions {0}'.format(i))

egl_khr_fence_sync = {}
spec['EGL_KHR_fence_sync'] = egl_khr_fence_sync
egl_khr_fence_sync['conformance'] = concurrent_test('egl_khr_fence_sync')

egl_chromium_sync_control = {}
spec['EGL_CHROMIUM_sync_control'] = egl_chromium_sync_control
egl_chromium_sync_control['conformance'] = concurrent_test('egl_chromium_sync_control')

gles20 = {}
spec['!OpenGL ES 2.0'] = gles20
gles20['glsl-fs-pointcoord'] = concurrent_test('glsl-fs-pointcoord_gles2')
add_concurrent_test(gles20, 'invalid-es3-queries_gles2')
gles20['link-no-vsfs'] = concurrent_test('link-no-vsfs_gles2')
add_concurrent_test(gles20, 'minmax_gles2')
add_concurrent_test(gles20, 'multiple-shader-objects_gles2')
add_concurrent_test(gles20, 'fbo_discard_gles2')
gles20['gles2_clear_varray-2.0'] = PiglitTest(['clear-varray-2.0_gles2', '-auto'])

gles30 = {}
spec['!OpenGL ES 3.0'] = gles30
for tex_format in ('rgb8', 'srgb8', 'rgba8', 'srgb8-alpha8', 'r11', 'rg11', 'rgb8-punchthrough-alpha1', 'srgb8-punchthrough-alpha1'):
    test_name = ' ' .join(['oes_compressed_etc2_texture-miptree_gles3', tex_format])
    executable = '{0} -auto'.format(test_name)
    gles30[test_name] = concurrent_test(executable)
gles30['minmax'] = concurrent_test('minmax_gles3')
for test_mode in ['teximage', 'texsubimage']:
    test_name = 'ext_texture_array-compressed_gles3 {0}'.format(test_mode)
    gles30[test_name] = PiglitTest(test_name + ' -auto -fbo')
gles30['texture-immutable-levels'] = concurrent_test('texture-immutable-levels_gles3')
gles30['gl_VertexID used with glDrawArrays'] = concurrent_test('gles-3.0-drawarrays-vertexid')

arb_es3_compatibility = {}
spec['ARB_ES3_compatibility'] = arb_es3_compatibility
for tex_format in ('rgb8', 'srgb8', 'rgba8', 'srgb8-alpha8', 'r11', 'rg11', 'rgb8-punchthrough-alpha1', 'srgb8-punchthrough-alpha1'):
    for context in ('core', 'compat'):
        test_name = ' ' .join(['oes_compressed_etc2_texture-miptree', tex_format, context])
        executable = '{0}'.format(test_name)
        arb_es3_compatibility[test_name] = concurrent_test(executable)

profile.tests['spec'] = spec
