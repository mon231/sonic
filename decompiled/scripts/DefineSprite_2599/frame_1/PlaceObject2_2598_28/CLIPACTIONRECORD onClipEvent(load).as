onClipEvent(load){
   if(_root.chara == "claude")
   {
      this.gotoAndStop("sonic");
   }
   else
   {
      this.gotoAndStop([_root.chara]);
   }
   if(_root.mode != "main")
   {
      this._visible = 0;
   }
}
