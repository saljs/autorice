#!/usr/bin/env python2.7
# -*- coding: utf-8 -*-
# vim:ts=2:sw=2:expandtab

import numpy as np
from PIL import Image
import sys

def palette(img):
    """
    Return palette  of image
    """
    arr = np.asarray(img)
    palette, index = np.unique(asvoid(arr).ravel(), return_inverse=True)
    palette = palette.view(arr.dtype).reshape(-1, arr.shape[-1])
    return palette

def asvoid(arr):
    """View the array as dtype np.void (bytes)
    This collapses ND-arrays to 1D-arrays, so you can perform 1D operations on them.
    http://stackoverflow.com/a/16216866/190597 (Jaime)
    http://stackoverflow.com/a/16840350/190597 (Jaime)
    Warning:
    >>> asvoid([-0.]) == asvoid([0.])
    array([False], dtype=bool)
    """
    arr = np.ascontiguousarray(arr)
    return arr.view(np.dtype((np.void, arr.dtype.itemsize * arr.shape[-1])))

img = Image.open(sys.argv[1], 'r').convert('RGB')
colors = palette(img)
#reference colors
ref = np.array([[0x00, 0x00, 0x00],
  [0xAA, 0x00, 0x00],
  [0x00, 0xAA, 0x00],
  [0xAA, 0x55, 0x00],
  [0x00, 0x00, 0xAA],
  [0xAA, 0x00, 0xAA],
  [0x00, 0xAA, 0xAA],
  [0xAA, 0xAA, 0xAA],
  [0x55, 0x55, 0x55],
  [0xFF, 0x55, 0x55],
  [0x55, 0xFF, 0x55],
  [0xFF, 0xFF, 0x55],
  [0x55, 0x55, 0xFF],
  [0xFF, 0x55, 0xFF],
  [0x55, 0xFF, 0xFF],
  [0xFF, 0xFF, 0xFF]])
distances = [255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255] 
output = np.zeros((16, 3), dtype=int)
for i in range(len(colors)):
  for j in range(len(ref)):
    total = 0
    total += abs(colors[i][0] - ref[j][0]) 
    total += abs(colors[i][1] - ref[j][1]) 
    total += abs(colors[i][2] - ref[j][2])
    total /= 3
    if total < distances[j]:
      distances[j] = total
      output[j] = colors[i]
for color in output:
  print("#" + format(color[0], '02x') + format(color[1], '02x') + format(color[2], '02x'))
