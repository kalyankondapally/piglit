# -*- coding: utf-8 -*-

from framework.gleantest import GleanTest
from tests.all import profile

__all__ = ['profile']

GleanTest.globalParams += ["--quick"]
