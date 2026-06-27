onClipEvent(load){
   if(_root.chara == "claude")
   {
      this.gotoAndStop("sonic");
   }
   else
   {
      this.gotoAndStop([_root.chara]);
   }
}
