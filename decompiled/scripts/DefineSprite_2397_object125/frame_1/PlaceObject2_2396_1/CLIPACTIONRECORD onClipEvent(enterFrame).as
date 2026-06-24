onClipEvent(enterFrame){
   if(_root.pause == 0)
   {
      if(this.pinit != "on")
      {
         this.pinit = "on";
         if(eval("../:object") == undefined)
         {
            this.pmode = "on";
            this._xscale = -100;
            set("../:energy",0);
         }
      }
      if(this.pmode == "on")
      {
         if(eval("../:energy") < 0)
         {
            this.gotoAndStop("explosion");
            if(this.pdie > 0)
            {
               this.pdie += 1;
            }
            else
            {
               this.pdie = 1;
            }
            if(this.pdie > 8)
            {
               _root[getProperty("../", _name)].removeMovieClip();
            }
         }
         else
         {
            if(this.pstate == "slide")
            {
               this.psx -= 6;
               _root[getProperty("../", _name)]._x = this.psx;
               this.gotoAndStop("move");
               if(_root[getProperty("../", _name)]._x < -30)
               {
                  _root[getProperty("../", _name)].removeMovieClip();
               }
            }
            else
            {
               _root[getProperty("../", _name)]._y += 8;
               _root[getProperty("../", _name)]._x = _root.bossobj._x;
               this.gotoAndStop("move");
               if(_root.level.hitTest(_root[getProperty("../", _name)]._x,_root[getProperty("../", _name)]._y + 12,true) || _root.level2.hitTest(_root[getProperty("../", _name)]._x,_root[getProperty("../", _name)]._y + 12,true))
               {
                  this.psx = _root[getProperty("../", _name)]._x;
                  this.pstate = "slide";
               }
               else if(270 < _root[getProperty("../", _name)]._y)
               {
                  _root[getProperty("../", _name)].removeMovieClip();
               }
            }
            if(this.hitTest(_root.Sonic1.hitb))
            {
               if(_root.Sonic1.roll == "on")
               {
                  set("../:energy",eval("../:energy") - 1);
               }
               else if(_root.Sonic1.j == "on")
               {
                  set("../:energy",eval("../:energy") - 1);
                  if(_root.Sonic1.y < 0)
                  {
                     _root.Sonic1.y *= -1;
                  }
                  _root.fx.fx("box");
                  _root.score += _root.scorev.enemy;
               }
               else
               {
                  _root.Sonic1.sethit();
               }
            }
         }
      }
      else if(eval("../:energy") >= 0)
      {
         if(_root.Level.pwh - 20 < _root.Levelo["p" add eval("../:object")][getProperty("../", _name)]._x)
         {
            if(0 < x)
            {
               x -= 0.5;
            }
            else
            {
               x = - speed;
            }
         }
         else if(_root.Levelo["p" add eval("../:object")][getProperty("../", _name)]._x < - _root.Level.pwh + 20)
         {
            if(x < 0)
            {
               x += 0.5;
            }
            else
            {
               x = speed;
            }
         }
         _root.Levelo["p" add eval("../:object")][getProperty("../", _name)]._x += x;
         if(x == speed || x == - speed)
         {
            this.gotoAndStop("move");
         }
         else
         {
            this.gotoAndStop("turn");
         }
         if(0 < x)
         {
            _root.Levelo["p" add eval("../:object")][getProperty("../", _name)]._xscale = 100;
         }
         else
         {
            _root.Levelo["p" add eval("../:object")][getProperty("../", _name)]._xscale = -100;
         }
         if(this.hitTest(_root.Sonic1.hitb))
         {
            if(_root.Sonic1.roll == "on")
            {
               set("../:energy",eval("../:energy") - 1);
            }
            else if(_root.Sonic1.j == "on")
            {
               set("../:energy",eval("../:energy") - 1);
               if(_root.Sonic1.y < 0)
               {
                  _root.Sonic1.y *= -1;
               }
               _root.fx.fx("box");
               _root.score += _root.scorev.enemy;
            }
            else
            {
               _root.Sonic1.sethit();
            }
         }
      }
      else
      {
         this.gotoAndStop("explosion");
      }
   }
}
