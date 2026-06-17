onClipEvent(load){
   function music(track, loop)
   {
      this.musicO.stop();
      this.musicO.setVolume(_root.musicvol);
      this.musicO.attachSound("music_" add track);
      this.musicO.start(0,loop);
   }
   stopAllSounds();
   this.musicO = new Sound(this);
   if(_root.boss == "on")
   {
      music("boss",999999);
   }
   else if(_root.czone == 1 || _root.czone == 2 && _root.cact == 3)
   {
      music("angelisland",999999);
   }
   else
   {
      music("snowparadise",999999);
   }
}
