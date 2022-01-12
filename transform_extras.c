void STACK_draw(WrenVM* vm) {
  DOME_Context ctx = core->getContext(vm);
  STACK * stack = wren->getSlotForeign(vm, 0);
  int32_t x = wren->getSlotDouble(vm, 1);
  int32_t y = wren->getSlotDouble(vm, 2);
  int32_t angleDeg = wren->getSlotDouble(vm, 3);
  //angleDeg+= 180;
  angleDeg %= 360;

  angleDeg = abs(angleDeg);
  float angle = (M_PI/180) * angleDeg;

  
  bool flip = false;

  if (angleDeg < 90 || angleDeg > 270) {
    flip = true;
    angle += M_PI;
  }
  

  int srcW = stack->sliceWidth;
  int srcH = stack->sliceHeight;
  int cX = stack->sliceWidth/2;
  int cY = stack->sliceHeight/2;

  float invangle = angle - M_PI;
  float tan = sin(invangle/2) / cos(invangle/2);

  int pitchDeg = wren->getSlotDouble(vm, 4);

  pitchDeg = fmin(pitchDeg, 90);

  float pitch = ((M_PI/180) * pitchDeg) - M_PI / 2;

  float scaleY = pitch / (M_PI / 2);
  float sliceOffset = 1;
  //int slices = stack->bmp.width / stack->sliceWidth;
  int slices = stack->bmp.height / stack->sliceHeight;
  for (int slice = 0; slice < slices; slice++) {
    for (int u = 0; u < stack->sliceWidth; u++) {
      for (int v = 0; v < stack->sliceHeight; v++) {

        DOME_Color preColor = STACK_pget(stack, (slices - 1) - slice, u, v);
        
        int destX = flip? srcW - u - cX : u - cX;
        int destY = flip? srcH - v - cY : v - cY;

        destX = round(destX - ( destY * tan));
        destY = round(destX*sin(invangle)+destY);
        destX = round(destX-destY*tan);

        destY = destY * scaleY;
        destY -= slice * sliceOffset;


        canvas->pset(ctx, x + -destX, y + destY, preColor);
      }
    }
  }
  printf("Scale: %f Pitch %f\n", scaleY, pitch);
} 

void STACK_draw2(WrenVM* vm) {
  DOME_Context ctx = core->getContext(vm);
  STACK * stack = wren->getSlotForeign(vm, 0);
  int32_t x = wren->getSlotDouble(vm, 1);
  int32_t y = wren->getSlotDouble(vm, 2);
  int32_t angleDeg = wren->getSlotDouble(vm, 3);
  float scaleY = wren->getSlotDouble(vm, 4);
  float sliceOffset = wren->getSlotDouble(vm, 5);

  //angleDeg+= 90;
  angleDeg %= 360;
  angleDeg = abs(angleDeg);
  float angle = (M_PI/180) * angleDeg;

  
  bool flip = false;

  if (angleDeg < 90 || angleDeg > 270) {
    flip = true;
    angle += M_PI;
  }
  
  int srcW = stack->sliceWidth;
  int srcH = stack->sliceHeight;
  int cX = stack->sliceWidth/2;
  int cY = stack->sliceHeight/2;

  float invangle = angle - M_PI;
  float tan = sin(invangle/2) / cos(invangle/2);

  //int slices = stack->bmp.width / stack->sliceWidth;
  int slices = stack->bmp.height / stack->sliceHeight;
  for (int slice = 0; slice < slices; slice++) {
    for (int u = 0; u < stack->sliceWidth; u++) {
      for (int v = 0; v < stack->sliceHeight; v++) {
        DOME_Color preColor = STACK_pget(stack, (slices - 1) - slice, u, v);
        
        int destX = flip? srcW - u - cX : u - cX;
        int destY = flip? srcH - v - cY : v - cY;

        destX = round(destX - ( destY * tan));
        destY = round(destX*sin(invangle)+destY);
        destX = round(destX-destY*tan);

        destY = destY * -scaleY;
        destY -= slice * sliceOffset;


        canvas->pset(ctx, x + -destX, y + destY, preColor);
      }
    }
  }
}