onClipEvent(enterFrame){
   if(Key.isDown(67))
   {
      if(!cshortcut)
      {
         cshortcut = true;
         _root.chara = "claude";
         _root.mode = "main";
         _root.czone = 1;
         _root.cact = 1;
         _root.cheat[8] = 2;
         _root.fade.play();
      }
   }
   else
   {
      cshortcut = false;
   }
   if(Key.isDown(90))
   {
      if(!zshortcut)
      {
         zshortcut = true;
         _root.chara = "claude";
         current2 = "character select";
         current = "character select";
         charaPage = 1;
      }
   }
   else
   {
      zshortcut = false;
   }
   if(Key.isDown(66))
   {
      if(!bshortcut)
      {
         bshortcut = true;
         _root.chara = "sonic";
         _root.mode = "main";
         _root.czone = 1;
         _root.cact = 1;
         _root.fade.play();
      }
   }
   else
   {
      bshortcut = false;
   }
   if(Key.isDown(84))
   {
      if(!tshortcut)
      {
         tshortcut = true;
         _root.chara = "tails";
         _root.mode = "main";
         _root.czone = 1;
         _root.cact = 1;
         _root.fade.play();
      }
   }
   else
   {
      tshortcut = false;
   }
   if(Key.isDown(89))
   {
      if(!yshortcut)
      {
         yshortcut = true;
         _root.chara = "tails";
         _root.mode = "main";
         _root.czone = 1;
         _root.cact = 1;
         _root.boss = "on";
         _root.cheat[8] = 2;
         _root.fade.play();
      }
   }
   else
   {
      yshortcut = false;
   }
   if(remove == "on")
   {
      if(this._x < 10)
      {
         this._x += 2;
      }
      else if(this._x < chx)
      {
         this._x += 50;
      }
   }
   else if(current != current2)
   {
      if(this._x < 10)
      {
         this._x += 2;
      }
      else if(this._x < chx)
      {
         this._x += 50;
      }
      else
      {
         this._x = -300;
         current = current2;
         setbuttons();
      }
   }
   else
   {
      this._x *= 0.5;
      this[current add "f"]();
   }
}
