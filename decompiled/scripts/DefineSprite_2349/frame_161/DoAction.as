if(_root.doubleboss == "on")
{
   _root.boss1dead = true;
   if(_root.boss2dead)
   {
      _root.attachMovie("Leveloutro","leveloutro",50);
   }
}
else
{
   _root.attachMovie("Leveloutro","leveloutro",50);
}
stop();
