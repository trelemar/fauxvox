import "graphics" for Canvas, ImageData, Color
import "plugin" for Plugin
import "flap" for Grid
import "math" for Vector, Math
import "input" for Keyboard

Plugin.load("transform")
import "transform" for Transform, Stack


var PlayerStack = Stack.new("/home/trevor/vox/sheet-1.png", 20, 21)
var CrateStack = Stack.new("/home/trevor/vox/crate.png", 16, 16)

class Player {
  construct new() {
    _x = 32
    _y = 32
    _vx = 0
    _vy = 0
    _vangle = 0
    _angle = 0
  }
  update() {
    if (!Keyboard["a"].down || !Keyboard["d"].down) {
      _vx = 0
    }
    if (Keyboard["a"].down) {
      _vx = -1
    }
    if (Keyboard["d"].down) {
      _vx = 1
    }

    if (!Keyboard["w"].down || !Keyboard["s"].down) {
      _vy = 0
    }
    if (Keyboard["w"].down) {
      _vy = -1
    }
    if (Keyboard["s"].down) {
      _vy = 1
    }
    
    //_vangle = 0
    /*
    if (_vy == 1) _vangle = 0
    if (_vy == -1) _vangle = 180
    if (_vx == 1) _vangle = 90
    if (_vx == -1) _vangle = 270
    */
    _vangle = Math.atan(-_vx, _vy)// + Num.pi

    _vangle = (_vangle*180) / Num.pi
    if (_vangle < 0) _vangle = _vangle + 360
    //_vangle = _vangle * 180 / Num.pi


    _angle = Math.lerp(_angle, 0.2, _vangle)


    _x = _x + _vx
    _y = _y + _vy
  }
  draw(pitch) {
    PlayerStack.draw(_x, _y, _angle, 0.75, 1)
    PlayerStack.draw(_x + 32, _y, _angle, 45)
    Canvas.print(_vangle, 32, 64, Color.white)
  }
}

class Main {
  construct new() {}

  init() {
    //_sheet = Transform.loadFromFile("sheet.png")
    _grid = Grid.new(32, 32, 320, 32)
    //_crate = Stack.new("crate.png", 16, 16)
    _t = 0
    _guy = Player.new()
    _pitch = 0
  }

  update() {
    _guy.update()

    //_pitch = (Num.pi/180) * (_t.sin)
    _pitch = _pitch + 1
  }

  draw(alpha) {
    Canvas.cls(Color.darkgray)
    _guy.draw(45)
    //_crate.draw(64, 32, _t)
    CrateStack.draw(64, 32, _t, 0.50, 0.8)
    CrateStack.drawp(64, 64, _t, )
    Canvas.print(_t%90, 2, 2, Color.white)
    Canvas.pset(64, 32, Color.white)
    _t = _t + 1
  }
}

var Game = Main.new()
