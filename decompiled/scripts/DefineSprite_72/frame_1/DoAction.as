if(_root.boss == "on")
{
   if(_root.doubleboss == "on")
   {
      t = "combo boss";
   }
   else
   {
      t = _root.bossn[_root.czone];
   }
}
else
{
   t = _root.act[_root.czone add "-" add _root.cact];
}
