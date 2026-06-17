onClipEvent(load){
   pw = 180;
   pwh = 90;
   count = 0;
   if(_root.czone == 2 && _root.cact == 3 && _root.boss != "on")
   {
      this.attachMovie("level-1","p1",1);
   }
   else
   {
      this.attachMovie("level-" add _root.czone,"p1",1);
   }
   this.p1._x = 0;
   this.p1._y = 0;
   this.p1.swapDepths(-1);
   var forvar = 2;
   while(9 >= forvar)
   {
      duplicateMovieClip("p1","p" add forvar,16384 + forvar);
      this["p" add forvar]._x = this.p1._x + (forvar - 1) * pw - count * (3 * pw);
      this["p" add forvar]._y = this.p1._y + count * pw;
      if(forvar == 3 || forvar == 6)
      {
         count += 1;
      }
      forvar++;
   }
}
