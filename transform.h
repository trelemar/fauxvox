#include <math.h>
#include "dome.h"
#ifndef M_PI
#define M_PI 3.14159265358979323846
#endif

typedef struct {
  int32_t x;
  int32_t y;
} iVEC;

typedef struct {
  DOME_Bitmap bmp;
  int32_t sliceWidth;
  int32_t sliceHeight;
} STACK;

static inline iVEC shear(float angle, float x, float y) {
  angle = angle - M_PI;
  double tan = sin(angle/2) / cos(angle/2);
  int newX = round(x-y*tan);
  int newY = y;

  //shear 2
  newY = round(newX*sin(angle)+newY);
  //shear3
  newX = round(newX-newY*tan);

  iVEC vec;
  vec.x = newX;
  vec.y = newY;
  return vec;
}

static DOME_API_v0* core;
static WREN_API_v0* wren;
static CANVAS_API_v0* canvas;
static BITMAP_API_v0* bitmap;
static IO_API_v0* io;

