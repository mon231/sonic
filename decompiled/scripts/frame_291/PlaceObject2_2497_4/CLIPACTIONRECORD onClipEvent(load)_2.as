onClipEvent(load){
   function setbuttons()
   {
      a = 1;
      this.b1.t = this[current][a].toUpperCase();
      a2start = 1;
      var a = 2;
      while(10 >= a)
      {
         if(0 < this[current][a].length || current == "cheats" && 8 >= a2start)
         {
            if(current == "cheats")
            {
               var maxCheat = 9;
               var pageSize = 5;
               var slot = 2;
               var cheatIdx = cheatPage + 1;
               var shown = 0;
               if(cheatPage > 0)
               {
                  duplicateMovieClip(this.b1,"b" add slot,16384 + slot);
                  this["b" add slot].d = "off";
                  this["b" add slot].t = "< PREV";
                  this["b" add slot].cn = "prev";
                  this["b" add slot]._y = this.b1._y + (slot - 1) * 15;
                  slot++;
               }
               while(cheatIdx <= maxCheat && shown < pageSize)
               {
                  if(_root.cheat[cheatIdx] != 0)
                  {
                     duplicateMovieClip(this.b1,"b" add slot,16384 + slot);
                     this["b" add slot].d = "off";
                     this["b" add slot].t = _root.cheat[cheatIdx add "-name"].toUpperCase();
                     this["b" add slot].cn = cheatIdx;
                     this["b" add slot]._y = this.b1._y + (slot - 1) * 15;
                     slot++;
                     shown++;
                  }
                  cheatIdx++;
               }
               var hasMore = false;
               var peek = cheatIdx;
               while(peek <= maxCheat)
               {
                  if(_root.cheat[peek] != 0)
                  {
                     hasMore = true;
                     break;
                  }
                  peek++;
               }
               if(hasMore)
               {
                  duplicateMovieClip(this.b1,"b" add slot,16384 + slot);
                  this["b" add slot].d = "off";
                  this["b" add slot].t = "NEXT >";
                  this["b" add slot].cn = "next";
                  this["b" add slot]._y = this.b1._y + (slot - 1) * 15;
                  slot++;
               }
               duplicateMovieClip(this.b1,"b" add slot,16384 + slot);
               this["b" add slot].d = "off";
               this["b" add slot].t = "BACK";
               this["b" add slot]._y = this.b1._y + (slot - 1) * 15;
               backn = slot;
               if(shown == 0 && cheatPage == 0)
               {
                  this.b1.t = "no cheats";
               }
               var cleanup = slot + 1;
               while(10 >= cleanup)
               {
                  this["b" add cleanup].removeMovieClip();
                  cleanup++;
               }
               a = 30;
            }
            else if(this[current][a add "-type"] == "regler")
            {
               attachMovie("Menu_regler","b" add a,a);
               this["b" add a].reg._x = _root[this[current][a]] / 100 * 75 - 50;
               this["b" add a]._y = this.b1._y + (a - 1) * 15;
               this["b" add a]._x = this.b1._x;
            }
            else if(this[current][a add "-type"] == "eingabe")
            {
               attachMovie("Menu_eingabe","b" add a,a);
               this["b" add a].t = this[current][a].toUpperCase();
               this["b" add a]._y = this.b1._y + (a - 1) * 15;
               this["b" add a]._x = this.b1._x;
            }
            else if(current == "chara")
            {
               var perPage = charaPerPage;
               var charCount = 0;
               var ci = 1;
               while(this[current][ci].length > 0 && this[current][ci] != "Start Game" && this[current][ci] != "back")
               {
                  charCount++;
                  ci++;
               }
               var slot = 1;
               if(charaPage > 0)
               {
                  if(slot > 1)
                  {
                     duplicateMovieClip(this.b1,"b" add slot,16384 + slot);
                  }
                  this["b" add slot].d = "off";
                  this["b" add slot].t = "< PREV";
                  this["b" add slot].cn = "prev";
                  this["b" add slot].charn = "";
                  this["b" add slot]._y = this.b1._y + (slot - 1) * 15;
                  slot++;
               }
               var idx = charaPage + 1;
               var shown = 0;
               while(idx <= charCount && shown < perPage)
               {
                  if(slot > 1)
                  {
                     duplicateMovieClip(this.b1,"b" add slot,16384 + slot);
                  }
                  this["b" add slot].d = "off";
                  this["b" add slot].cn = "";
                  this["b" add slot].charn = this[current][idx].toLowerCase();
                  var lbl = this[current][idx].toUpperCase();
                  if(idx == 5 && _root.unlock[1] != 1)
                  {
                     lbl = " ";
                     this["b" add slot].charn = "";
                  }
                  else if(idx == 6 && _root.unlock[2] != 1)
                  {
                     lbl = " ";
                     this["b" add slot].charn = "";
                  }
                  this["b" add slot].t = lbl;
                  this["b" add slot]._y = this.b1._y + (slot - 1) * 15;
                  slot++;
                  shown++;
                  idx++;
               }
               if(idx <= charCount)
               {
                  if(slot > 1)
                  {
                     duplicateMovieClip(this.b1,"b" add slot,16384 + slot);
                  }
                  this["b" add slot].d = "off";
                  this["b" add slot].t = "NEXT >";
                  this["b" add slot].cn = "next";
                  this["b" add slot].charn = "";
                  this["b" add slot]._y = this.b1._y + (slot - 1) * 15;
                  slot++;
               }
               if(slot > 1)
               {
                  duplicateMovieClip(this.b1,"b" add slot,16384 + slot);
               }
               this["b" add slot].d = "off";
               this["b" add slot].t = "START GAME";
               this["b" add slot].cn = "start";
               this["b" add slot].charn = "";
               this["b" add slot]._y = this.b1._y + (slot - 1) * 15;
               slot++;
               if(slot > 1)
               {
                  duplicateMovieClip(this.b1,"b" add slot,16384 + slot);
               }
               this["b" add slot].d = "off";
               this["b" add slot].t = "BACK";
               this["b" add slot].cn = "back";
               this["b" add slot].charn = "";
               this["b" add slot]._y = this.b1._y + (slot - 1) * 15;
               backn = slot;
               slot++;
               var cleanup = slot;
               while(10 >= cleanup)
               {
                  this["b" add cleanup].removeMovieClip();
                  cleanup++;
               }
               a = 30;
            }
            else
            {
               this["b" add a].d = "off";
               duplicateMovieClip(this.b1,"b" add a,16384 + a);
               this["b" add a].t = this[current][a].toUpperCase();
               this["b" add a]._y = this.b1._y + (a - 1) * 15;
            }
         }
         else
         {
            this["b" add a].removeMovieClip();
         }
         a++;
      }
   }
   tsx = _root.title._x;
   tsy = _root.title._y;
   chx = 500;
   current2 = "main";
}
