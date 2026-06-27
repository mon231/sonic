function getpasswd()
{
   pass = new Array();
   pass[1] = _root.save.sonic;
   pass[2] = _root.save.tails;
   pass[3] = _root.save.knuckles;
   pass[4] = _root.save.cream;
   pass[5] = _root.save.amy;
   pass[6] = _root.save.shadow;
   passsum = 0;
   var a = 1;
   while(6 >= a)
   {
      passsum += Number(pass[a]);
      a++;
   }
   passsum = Math.floor(passsum * 3.2);
   if(passsum < 10)
   {
      passsum = "00" add passsum;
   }
   else if(passsum < 100)
   {
      passsum = "0" add passsum;
   }
   else
   {
      passsum = passsum.toString();
      passsum = passsum.charAt(0) add passsum.charAt(1) add passsum.charAt(2);
   }
   val = passsum;
   var a = 1;
   while(6 >= a)
   {
      val = val add pass[a];
      a++;
   }
   return val;
}
function setcheats()
{
   var a = 1;
   while(9 >= a)
   {
      if(_root.cheat[a] == 0)
      {
         _root.cheat[a] = 1;
      }
      a++;
   }
   _root.unlock[1] = 1;
   _root.unlock[2] = 1;
   _root.unlock[3] = 1;
}
_root.musicvol = 100;
_root.FXvol = 100;
_root.chara = "sonic";
_root.record = new Array();
_root.scorev = new Array();
_root.scorev.enemy = 10;
var a = 1;
while(5 >= a)
{
   var a2 = 1;
   while(5 >= a2)
   {
      _root.record[a add "-" add a2] = "9:59:99";
      _root.record[a add "-" add a2 add "-char"] = "sonic";
      a2++;
   }
   a++;
}
_root.cheat = new Array();
var a = 1;
while(9 >= a)
{
   _root.cheat[a] = 0;
   a++;
}
_root.cheat["1-name"] = "sonic-run 2";
_root.cheat["2-name"] = "tails follow";
_root.cheat["3-name"] = "behind";
_root.cheat["4-name"] = "big-cheese";
_root.cheat["5-name"] = "moon";
_root.cheat["6-name"] = "all fly";
_root.cheat["7-name"] = "infinite-fly";
_root.cheat["8-name"] = "invincible";
_root.cheat["9-name"] = "ring back";
_root.unlock = new Array();
_root.unlock[1] = 0;
_root.unlock[2] = 0;
_root.unlock[3] = 0;
_root.save = new Array();
_root.save.sonic = "01";
_root.save.tails = "01";
_root.save.knuckles = "01";
_root.save.cream = "01";
_root.save.amy = "01";
_root.save.shadow = "01";
_root.save.claude = "01";
_root.makeClaude = function(ctrl)
{
   var hb = ctrl.hitb.getBounds(ctrl);
   ctrl.cw = (hb.xMax - hb.xMin) * 1.15;
   ctrl.ch = (hb.yMax - hb.yMin) * 1.15;
   ctrl.cxc = (hb.xMin + hb.xMax) / 2;
   ctrl.cyc = (hb.yMin + hb.yMax) / 2;
   ctrl.attachMovie("knuckles","kroll",200);
   ctrl.kroll._visible = false;
   ctrl.attachMovie("select_sonic","cstreak",199);
   ctrl.cstreak.loadMovie("resources/streak.png");
   ctrl.cstreak._visible = false;
   ctrl.attachMovie("select_sonic","cpuff",202);
   ctrl.cpuff.loadMovie("resources/puff.png");
   ctrl.cpuff._visible = false;
   ctrl.attachMovie("select_sonic","csad",203);
   ctrl.csad.loadMovie("resources/claude_sad.png");
   ctrl.csad._visible = false;
   ctrl.sonic.loadMovie("resources/claude.png");
   ctrl.ct = 0;
   ctrl.pj = "off";
   ctrl.pufft = 0;
   ctrl.fxready = false;
};
_root.animClaude = function(ctrl)
{
   var ic = ctrl.sonic;
   ctrl.ct = ctrl.ct + 1;
   var t = ctrl.ct;
   var flying = ctrl.fly != undefined && ctrl.fly != "off";
   var air = ctrl.g != "on";
   var sp = ctrl.x;
   if(sp < 0)
   {
      sp = - sp;
   }
   var dir = 1;
   if(ctrl.x < 0)
   {
      dir = -1;
   }
   if(ctrl.j == "on" && ctrl.pj != "on" && !flying)
   {
      ctrl.pufft = 6;
   }
   ctrl.pj = ctrl.j;
   var tired = flying && ctrl.fly != "on" && Number(ctrl.fly) <= 30;
   var tlvl = 0;
   if(tired)
   {
      tlvl = (30 - Number(ctrl.fly)) / 30;
      if(tlvl > 1)
      {
         tlvl = 1;
      }
      if(tlvl < 0)
      {
         tlvl = 0;
      }
   }
   if(ctrl.fxready != true)
   {
      if(ctrl.cstreak._width > 0 && ctrl.cpuff._width > 0)
      {
         ctrl.fxready = true;
      }
   }
   if(ctrl.fxready == true)
   {
      ctrl.cstreak._visible = false;
      ctrl.cstreak._xscale = 0;
      ctrl.cstreak._yscale = 0;
      ctrl.cstreak._x = ctrl.cxc;
      ctrl.cstreak._y = ctrl.cyc;
      ctrl.cpuff._visible = false;
      ctrl.cpuff._xscale = 0;
      ctrl.cpuff._yscale = 0;
      ctrl.cpuff._x = ctrl.cxc;
      ctrl.cpuff._y = ctrl.cyc;
      ctrl.kroll._visible = false;
      ctrl.kroll._xscale = 0;
      ctrl.kroll._yscale = 0;
      ctrl.kroll._x = ctrl.cxc;
      ctrl.kroll._y = ctrl.cyc;
      if(!air && !flying && ctrl.roll != "on" && sp > 8)
      {
         ctrl.cstreak._visible = true;
         var ss = (sp - 8) / 9;
         if(ss > 1)
         {
            ss = 1;
         }
         var sw = ctrl.cw * (1.2 + 0.6 * ss);
         var sh = ctrl.ch * (0.5 + 0.1 * Math.sin(t * 1.5));
         ctrl.cstreak._width = sw;
         ctrl.cstreak._height = sh;
         ctrl.cstreak._x = ctrl.cxc - sw / 2 - dir * ctrl.cw * 0.2;
         ctrl.cstreak._y = ctrl.cyc - sh / 2;
         ctrl.cstreak._alpha = 35 + 50 * ss;
      }
      var skid = ctrl.br == "on" && !air && !flying;
      if(ctrl.pufft > 0 || skid)
      {
         ctrl.cpuff._visible = true;
         var pg = 1;
         if(ctrl.pufft > 0)
         {
            pg = ctrl.pufft / 6;
         }
         var pw = ctrl.cw * (0.7 + 0.6 * (1 - pg));
         var ph = ctrl.ch * (0.5 + 0.4 * (1 - pg));
         ctrl.cpuff._width = pw;
         ctrl.cpuff._height = ph;
         if(skid)
         {
            ctrl.cpuff._x = ctrl.cxc - pw / 2 - dir * ctrl.cw * 0.45;
            ctrl.cpuff._alpha = 80;
         }
         else
         {
            ctrl.cpuff._x = ctrl.cxc - pw / 2;
            ctrl.cpuff._alpha = 95 * pg;
         }
         ctrl.cpuff._y = ctrl.cyc + ctrl.ch / 2 - ph * 0.8;
      }
   }
   else
   {
      ctrl.cstreak._visible = false;
      ctrl.cpuff._visible = false;
      ctrl.kroll._visible = false;
   }
   if(ctrl.pufft > 0)
   {
      ctrl.pufft = ctrl.pufft - 1;
   }
   if(!flying && (ctrl.roll == "on" || ctrl.j == "on"))
   {
      ctrl.kroll._visible = false;
      ctrl.csad._visible = false;
      ic._visible = true;
      if(ic._width > 0)
      {
         ic._xscale = ctrl.cw / 256 * 100;
         ic._yscale = ctrl.ch / 256 * 100;
         ic._rotation = ctrl.ct * 28;
         ic._x = ctrl.cxc - ic._width / 2;
         ic._y = ctrl.cyc - ic._height / 2;
      }
      return undefined;
   }
   ic._visible = true;
   if(ic._width <= 0)
   {
      return undefined;
   }
   var ducking = ctrl.duck == "on";
   var bxs = ctrl.cw / 256 * 100;
   var bys = ctrl.ch / 256 * 100;
   var fx = 1;
   var fy = 1;
   var oy = 0;
   var rotw = 0;
   if(ducking)
   {
      fx = 1.2;
      fy = 0.5;
   }
   else if(flying)
   {
      oy = -3 - 3 * Math.sin(t * 0.3);
      if(tired)
      {
         rotw = (6 + 9 * tlvl) * Math.sin(t * (0.5 + 0.4 * tlvl));
         oy = oy + 5 * tlvl;
         fy = 1 - 0.06 * tlvl;
      }
   }
   else if(air)
   {
      if(ctrl.y < 0)
      {
         fy = 1.25;
         fx = 0.82;
      }
      else
      {
         fy = 0.85;
         fx = 1.15;
      }
   }
   else if(sp > 0.5)
   {
      var w = 1 + 0.1 * Math.sin(t * (0.5 + sp * 0.08));
      fy = w;
      fx = 2 - w;
   }
   else
   {
      var bb = 1 + 0.04 * Math.sin(t * 0.15);
      fx = bb;
      fy = bb;
   }
   var sad = (ctrl.hit == "on" || tired) && ctrl.csad._width > 0;
   ic._xscale = bxs * fx;
   ic._yscale = bys * fy;
   ic._rotation = rotw;
   ic._x = ctrl.cxc - ic._width / 2;
   ic._y = ctrl.cyc - ic._height / 2 + oy;
   ic._visible = !sad;
   if(ctrl.csad._width > 0)
   {
      ctrl.csad._xscale = bxs * fx;
      ctrl.csad._yscale = bys * fy;
      ctrl.csad._rotation = rotw;
      ctrl.csad._x = ctrl.cxc - ctrl.csad._width / 2;
      ctrl.csad._y = ctrl.cyc - ctrl.csad._height / 2 + oy;
      ctrl.csad._visible = sad;
   }
};
_root.zone = new Array();
_root.act = new Array();
_root.bossn = new Array();
_root.bossn[1] = "spinning egg";
_root.bossn[2] = "egg bomber";
_root.czone = 1;
_root.cact = 1;
_root.doubleboss = "off";
_root.penguinboss = "off";
_root.zone[1] = "LEAF FOREST";
_root.act["1-bosstime"] = 120;
_root.act["1-1"] = "chill gardens";
_root.act["1-1-time"] = 60;
_root.act["1-2"] = "emerald forest";
_root.act["1-2-time"] = 70;
_root.act["1-3"] = "boss: spinning egg";
_root.zone[2] = "ICE PARADISE";
_root.act["2-bosstime"] = 120;
_root.act["2-1"] = "snowy mountain";
_root.act["2-1-time"] = 60;
_root.act["2-2"] = "frosty island";
_root.act["2-2-time"] = 70;
_root.act["2-3"] = "frozen garden";
_root.act["2-3-time"] = 60;
_root.zone[3] = "BOSS ZONE";
_root.act["3-1"] = "egg bomber";
_root.act["3-2"] = "combo boss";
_root.act["3-3"] = "animal-dropper";
_root.zone[4] = "ENERGY PLANT";
_root.act["4-1"] = "powersource";
_root.act["4-2"] = "omega station";
_root.act["4-3"] = "omega station";
_root.act["4-4"] = "thunderstorm";
_root.act["4-5"] = "ultimate showdown";
_root.zone[5] = "RED MOUNTAIN";
_root.act["5-1"] = "windy valley";
_root.act["5-2"] = "mystic cave";
_root.zones = 2;
