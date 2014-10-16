/* Copyright © 2012 Intel Corporation
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice (including the next
 * paragraph) shall be included in all copies or substantial portions of the
 * Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
 * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
 * IN THE SOFTWARE.
 */

/**
 * \file
 *
 * Summary
 * -------
 * Request various flavors of contexts and verify that the context's actual
 * flavor is compatible with the requested flavor.
 *
 *
 * Details
 * --------
 * for each OpenGL API:
 *     `api` := the chosen OpenGL API
 *
 *     for many (context version, profile) in `api`:
 *         `flavor` := the chosen combination of version and profile
 *
 *         call eglBindAPI(`api`)
 *         if the binding failed:
 *             skip `api`
 *
 *         request a minimal EGLConfig with EGL_RENDERABLE_TYPE = `api`
 *         if request fails:
 *             skip `api`
 *
 *         request an EGLContext of `flavor`
 *         if request fails:
 *             if the EGL error is not EGL_SUCCESS:
 *                 `result` := skip
 *             else:
 *                 `result` := fail
 *
 *             continue to next `flavor`
 *
 *        if the context's actual flavor is compatible with the requested `flavor`:
 *            `result` := pass
 *        else:
 *            `result` := fail
 *
 *        continue to next `flavor`
 */
#include <ctype.h>
#include <dlfcn.h>
#include <string.h>

#include "piglit-util-gl.h"
#include "piglit-util-egl.h"
#include "common.h"

enum gl_api {
	API_GL_COMPAT,
	API_GL_CORE,
	API_GLES1,
	API_GLES2,
	API_GLES3,
};


/* This test doesn't use the glGetString/glGetIntegerv symbols because
 * using piglit-dispatch introduces difficulties with this test.
 * Instead we choose to bypass dispatch by calling dlsym directly.
 */
static void (*my_glGetIntegerv)(GLenum pname, GLint *params);
static const char* (*my_glGetString)(GLenum pname);

#if defined(_WIN32)

void dispatch_init(piglit_dispatch_api dispatch_api) {
	(void)dispatch_api;
	my_glGetString = (void*) eglGetProcAddress("glGetString");
	my_glGetIntegerv = (void*) eglGetProcAddress("glGetIntegerv");
}

#elif defined(__APPLE__)

void dispatch_init(piglit_dispatch_api dispatch_api) {
	(void)dispatch_api;
	my_glGetString = (void*) eglGetProcAddress("glGetString");
	my_glGetIntegerv = (void*) eglGetProcAddress("glGetIntegerv");
}

#else /* Linux */

#define GLX_LIB "libGL.so.1"
#define GLES1_LIB "libGLESv1_CM.so.1"
#define GLES2_LIB "libGLESv2.so.2"

/** dlopen() return value for libGL.so.1 */
static void *glx_handle;

/** dlopen() return value for libGLESv1_CM.so.1 */
static void *gles1_handle;

/** dlopen() return value for libGLESv2.so.2 */
static void *gles2_handle;

static void *
do_dlsym(void **handle, const char *lib_name, const char *function_name)
{
	void *result;

	if (!*handle)
		*handle = dlopen(lib_name, RTLD_LAZY | RTLD_LOCAL);

	if (!*handle) {
		fprintf(stderr, "Could not open %s: %s\n", lib_name, dlerror());
		return NULL;
	}

	result = dlsym(*handle, function_name);
	if (!result)
		fprintf(stderr, "%s() not found in %s: %s\n", function_name, lib_name,
			dlerror());

	return result;
}

void dispatch_init(enum gl_api api) {
	void **handle = NULL;
	const char *lib_name = "";

	switch (api) {
	case API_GL_COMPAT:
	case API_GL_CORE:
		handle = &glx_handle;
		lib_name = GLX_LIB;
		break;
	case API_GLES1:
		handle = &gles1_handle;
		lib_name = GLES1_LIB;
		break;
	case API_GLES2:
	case API_GLES3:
		handle = &gles2_handle;
		lib_name = GLES2_LIB;
		break;
	}

	my_glGetString = do_dlsym(handle, lib_name, "glGetString");
	my_glGetIntegerv = do_dlsym(handle, lib_name, "glGetIntegerv");
}

#endif

static void
fold_results(enum piglit_result *a, enum piglit_result b)
{
	if (*a == PIGLIT_FAIL || b == PIGLIT_FAIL)
		*a = PIGLIT_FAIL;
	else if (*a == PIGLIT_PASS || b == PIGLIT_PASS)
		*a = PIGLIT_PASS;
	else
		*a = PIGLIT_SKIP;
}

int
get_gl_version(void)
{
	const char *version_string;
	int scanf_count;

	int major;
	int minor;

	version_string = (const char*) my_glGetString(GL_VERSION);

	/* Skip to version number. */
	while (!isdigit(*version_string) && *version_string != '\0')
		version_string++;

	/* Interpret version number. */
	scanf_count = sscanf(version_string, "%i.%i", &major, &minor);
	if (scanf_count != 2) {
		printf("error: Unable to interpret GL_VERSION string: %s\n",
		       version_string);
		piglit_report_result(PIGLIT_FAIL);
	}

	if (major >= 3) {
		/* Verify the glGetIntegerv returns the same version as
		 * glGetString.
		 */

		int major2;
		int minor2;

		my_glGetIntegerv(GL_MAJOR_VERSION, &major2);
		my_glGetIntegerv(GL_MINOR_VERSION, &minor2);

		if (major != major2 || minor != minor2) {
			printf("error: glGetString reports version %d.%d "
			       "but glGetIntegerv reports version %d.%d.\n",
			       major, minor,
			       major2, minor2);
			piglit_report_result(PIGLIT_FAIL);
		}
	}

	return 10 * major + minor;
}

static enum piglit_result
check_flavor(int requested_version, enum gl_api requested_api)
{
	enum piglit_result result = PIGLIT_PASS;
	int i;

	const char *api_name = NULL;
	const char *profile_name = "";

	EGLint context_attribs[64];
	EGLContext ctx = 0;

	EGLenum requested_client_type = 0;
	EGLint actual_client_type = 0;
	int actual_version = 0;
	GLint actual_profile = 0;

	switch (requested_api) {
	case API_GL_COMPAT:
		requested_client_type = EGL_OPENGL_API;
		api_name = "OpenGL";
		if (requested_version >= 32)
			profile_name = "compatibility ";
		break;
	case API_GL_CORE:
		requested_client_type = EGL_OPENGL_API;
		api_name = "OpenGL";
		if (requested_version >= 32)
			profile_name = "core ";
		break;
	case API_GLES1:
	case API_GLES2:
	case API_GLES3:
		requested_client_type = EGL_OPENGL_ES_API;
		api_name = "OpenGL ES";
		break;
	default:
		assert(0);
		break;
	}

	printf("info: request an %s %d.%d %scontext\n",
	       api_name,
	       requested_version / 10,
	       requested_version % 10,
	       profile_name);

	if (!eglBindAPI(requested_client_type)) {
		/* Assume the driver doesn't support the requested API. */
		result = PIGLIT_SKIP;
		goto cleanup;
	}

	i = 0;
	context_attribs[i++] = EGL_CONTEXT_MAJOR_VERSION_KHR;
	context_attribs[i++] = requested_version / 10;
	context_attribs[i++] = EGL_CONTEXT_MINOR_VERSION_KHR;
	context_attribs[i++] = requested_version % 10;
	if (requested_api == API_GL_CORE) {
		context_attribs[i++] = EGL_CONTEXT_OPENGL_PROFILE_MASK_KHR;
		context_attribs[i++] = EGL_CONTEXT_OPENGL_CORE_PROFILE_BIT_KHR;
	} else if (requested_api == API_GL_COMPAT) {
		context_attribs[i++] = EGL_CONTEXT_OPENGL_PROFILE_MASK_KHR;
		context_attribs[i++] = EGL_CONTEXT_OPENGL_COMPATIBILITY_PROFILE_BIT_KHR;
	}
	context_attribs[i++] = EGL_NONE;

	ctx = eglCreateContext(egl_dpy, cfg, EGL_NO_CONTEXT, context_attribs);

	if (ctx == NULL) {
		printf("%s", "info: context creation failed\n");
		if (eglGetError() != EGL_SUCCESS) {
			result = PIGLIT_SKIP;
		} else {
			printf("%s", "error: eglCreateContext failed but "
			       "the EGL error is EGL_SUCCESS\n");
			result = PIGLIT_FAIL;
		}

		goto cleanup;
	}

	if (!piglit_check_egl_error(EGL_SUCCESS)) {
		result = PIGLIT_FAIL;
		goto cleanup;
	}

	if (!eglMakeCurrent(egl_dpy, EGL_NO_SURFACE,
			    EGL_NO_SURFACE, ctx)) {
		printf("%s", "error: failed to make context current\n");
		goto fail;
	}

	dispatch_init(requested_api);

	if (!eglQueryContext(egl_dpy, ctx,
			     EGL_CONTEXT_CLIENT_TYPE, &actual_client_type)) {
		printf("%s", "error: eglQueryContext(EGL_CONTEXT_CLIENT_TYPE) "
		       "failed\n");
		goto fail;
	}

	if (actual_client_type != requested_client_type) {
		printf("error: requested a context with EGL_CONTEXT_CLIENT_TYPE=0x%x "
		       "but received one with EGL_CONTEXT_CLIENT_TYPE=0x%x.\n",
		       requested_client_type,
		       actual_client_type);
		goto fail;
	}

	actual_version = get_gl_version();

	if (actual_version < requested_version) {
		printf("error: requested context version %d.%d but received "
		       "version %d.%d\n",
		       requested_version / 10, requested_version % 10,
		       actual_version / 10, actual_version % 10);
		goto fail;
	}

	if (requested_api == API_GL_CORE ||
	    (requested_api == API_GL_COMPAT && requested_version >= 32)) {
		my_glGetIntegerv(GL_CONTEXT_PROFILE_MASK, &actual_profile);
		if (!piglit_check_gl_error(GL_NO_ERROR)) {
			printf("%s", "error: glGetIntegerv(GL_CONTEXT_PROFILE_MASK)"
			       "failed\n");
			goto fail;
		}
	}

	if (requested_api == API_GL_CORE) {
		assert(requested_version >= 32);
		if (actual_profile != EGL_CONTEXT_OPENGL_CORE_PROFILE_BIT_KHR) {
			printf("error: requested an OpenGL %d.%d core context, "
			       "but received a context whose profile "
			       "mask is 0x%x.\n",
			       requested_version / 10, requested_version % 10,
			       actual_profile);
			goto fail;
		}
	} else if (requested_api == API_GL_COMPAT && requested_version >= 32) {
		if (actual_profile != EGL_CONTEXT_OPENGL_COMPATIBILITY_PROFILE_BIT_KHR) {
			printf("error: requested an OpenGL %d.%d compatibility context, "
			       "but received a context whose profile "
			       "mask is 0x%x.\n",
			       requested_version / 10, requested_version % 10,
			       actual_profile);
			goto fail;
		}
	} else if (requested_api == API_GLES1) {
		if (actual_version > 11) {
			printf("error: requested an OpenGL ES %d.%d context, "
			       "but received %d.%d context.\n",
			       requested_version / 10, requested_version % 10,
			       actual_version / 10, actual_version % 10);
			goto fail;
		}
	} else if (requested_api == API_GLES2) {
		/* Nothing special to check. */
	}

	result = PIGLIT_PASS;
	goto cleanup;

fail:
	result = PIGLIT_FAIL;
	goto cleanup;

cleanup:
	/* We must unbind the context here due to a subtle requirement in the
	 * EGL 1.4 spec published on 2011-04-06. The call to eglMakeCurrent at
	 * the top of this function may attempt to bind a context whose api
	 * differs from the api of the current context. Yet, according to the
	 * EGL spec, it is illegal to bind a GL context to a surface if an ES
	 * context is currently bound to it, and vice versa.
	 *
	 * A future revision of the EGL 1.4 spec will fix this non-intuitive
	 * requirement.
	 */
	if (!eglMakeCurrent(egl_dpy, EGL_NO_SURFACE, EGL_NO_SURFACE,
			    EGL_NO_CONTEXT)) {
		printf("%s", "error: failed to unbind any current context\n");
		piglit_report_result(PIGLIT_FAIL);
	}

	switch (result) {
	case PIGLIT_PASS:
		printf("%s", "info: pass\n");
		break;
	case PIGLIT_FAIL:
		printf("%s", "info: fail\n");
		break;
	case PIGLIT_SKIP:
		printf("%s", "info: skip\n");
		break;
	case PIGLIT_WARN:
	default:
		assert(0);
		break;
	}

	return result;
}

static enum piglit_result
check_opengl(void)
{
	enum piglit_result result = PIGLIT_SKIP;

	if (!EGL_KHR_create_context_setup(EGL_OPENGL_BIT))
		return PIGLIT_SKIP;

	/* Try all valid OpenGL compatibility context versions. */
	fold_results(&result, check_flavor(10, API_GL_COMPAT));
	fold_results(&result, check_flavor(11, API_GL_COMPAT));
	fold_results(&result, check_flavor(12, API_GL_COMPAT));
	fold_results(&result, check_flavor(13, API_GL_COMPAT));
	fold_results(&result, check_flavor(14, API_GL_COMPAT));
	fold_results(&result, check_flavor(15, API_GL_COMPAT));
	fold_results(&result, check_flavor(16, API_GL_COMPAT));
	fold_results(&result, check_flavor(17, API_GL_COMPAT));
	fold_results(&result, check_flavor(20, API_GL_COMPAT));
	fold_results(&result, check_flavor(21, API_GL_COMPAT));
	fold_results(&result, check_flavor(22, API_GL_COMPAT));
	fold_results(&result, check_flavor(23, API_GL_COMPAT));
	fold_results(&result, check_flavor(24, API_GL_COMPAT));
	fold_results(&result, check_flavor(25, API_GL_COMPAT));
	fold_results(&result, check_flavor(26, API_GL_COMPAT));
	fold_results(&result, check_flavor(27, API_GL_COMPAT));
	fold_results(&result, check_flavor(30, API_GL_COMPAT));
	fold_results(&result, check_flavor(31, API_GL_COMPAT));
	fold_results(&result, check_flavor(32, API_GL_COMPAT));
	fold_results(&result, check_flavor(33, API_GL_COMPAT));
	fold_results(&result, check_flavor(34, API_GL_COMPAT));
	fold_results(&result, check_flavor(35, API_GL_COMPAT));
	fold_results(&result, check_flavor(36, API_GL_COMPAT));
	fold_results(&result, check_flavor(37, API_GL_COMPAT));
	fold_results(&result, check_flavor(40, API_GL_COMPAT));
	fold_results(&result, check_flavor(41, API_GL_COMPAT));
	fold_results(&result, check_flavor(42, API_GL_COMPAT));
	fold_results(&result, check_flavor(43, API_GL_COMPAT));
	fold_results(&result, check_flavor(44, API_GL_COMPAT));
	fold_results(&result, check_flavor(45, API_GL_COMPAT));
	fold_results(&result, check_flavor(46, API_GL_COMPAT));
	fold_results(&result, check_flavor(47, API_GL_COMPAT));

	/* Try all valid OpenGL core context versions. */
	fold_results(&result, check_flavor(32, API_GL_CORE));
	fold_results(&result, check_flavor(33, API_GL_CORE));
	fold_results(&result, check_flavor(34, API_GL_CORE));
	fold_results(&result, check_flavor(35, API_GL_CORE));
	fold_results(&result, check_flavor(36, API_GL_CORE));
	fold_results(&result, check_flavor(37, API_GL_CORE));
	fold_results(&result, check_flavor(40, API_GL_CORE));
	fold_results(&result, check_flavor(41, API_GL_CORE));
	fold_results(&result, check_flavor(42, API_GL_CORE));
	fold_results(&result, check_flavor(43, API_GL_CORE));
	fold_results(&result, check_flavor(44, API_GL_CORE));
	fold_results(&result, check_flavor(45, API_GL_CORE));
	fold_results(&result, check_flavor(46, API_GL_CORE));
	fold_results(&result, check_flavor(47, API_GL_CORE));

	EGL_KHR_create_context_teardown();
	return result;
}

static enum piglit_result
check_opengl_es1(void)
{
	enum piglit_result result = PIGLIT_SKIP;

	if (!EGL_KHR_create_context_setup(EGL_OPENGL_ES_BIT))
		return PIGLIT_SKIP;

	/* Try OpenGL ES1 context versions. */
	fold_results(&result, check_flavor(10, API_GLES1));
	fold_results(&result, check_flavor(11, API_GLES1));
	fold_results(&result, check_flavor(12, API_GLES1));
	fold_results(&result, check_flavor(13, API_GLES1));

	EGL_KHR_create_context_teardown();
	return result;
}

static enum piglit_result
check_opengl_es2(void)
{
	enum piglit_result result = PIGLIT_SKIP;

	if (!EGL_KHR_create_context_setup(EGL_OPENGL_ES2_BIT))
		return PIGLIT_SKIP;

	/* Try OpenGL ES2 context versions. */
	fold_results(&result, check_flavor(20, API_GLES2));
	fold_results(&result, check_flavor(21, API_GLES2));
	fold_results(&result, check_flavor(22, API_GLES2));
	fold_results(&result, check_flavor(23, API_GLES2));
	fold_results(&result, check_flavor(24, API_GLES2));
	fold_results(&result, check_flavor(25, API_GLES2));
	fold_results(&result, check_flavor(26, API_GLES2));
	fold_results(&result, check_flavor(27, API_GLES2));

	EGL_KHR_create_context_teardown();
	return result;
}

static enum piglit_result
check_opengl_es3(void)
{
	enum piglit_result result = PIGLIT_SKIP;

	if (!EGL_KHR_create_context_setup(EGL_OPENGL_ES3_BIT_KHR))
		return PIGLIT_SKIP;

	fold_results(&result, check_flavor(30, API_GLES3));
	fold_results(&result, check_flavor(31, API_GLES3));
	fold_results(&result, check_flavor(32, API_GLES3));
	fold_results(&result, check_flavor(33, API_GLES3));
	fold_results(&result, check_flavor(34, API_GLES3));
	fold_results(&result, check_flavor(35, API_GLES3));
	fold_results(&result, check_flavor(36, API_GLES3));
	fold_results(&result, check_flavor(37, API_GLES3));

	EGL_KHR_create_context_teardown();
	return result;
}

int
main(int argc, char **argv)
{
	enum piglit_result result = PIGLIT_SKIP;

	fold_results(&result, check_opengl());
	fold_results(&result, check_opengl_es1());
	fold_results(&result, check_opengl_es2());
	fold_results(&result, check_opengl_es3());

	piglit_report_result(result);
	return EXIT_SUCCESS;
}
