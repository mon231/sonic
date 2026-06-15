# Ultimate Sonic Flash — Modded
[Click To Play](https://mon231.github.io/sonic/)

A community mod of the classic *Ultimate Sonic* Flash game, adding quality-of-life cheats and gameplay features including universal flying, a ring magnet, and a ground pound.

The original game was published on Newgrounds and is now copyright-free. Flash games are run today via the [Ruffle](https://ruffle.rs/) browser extension or desktop player, which emulates the Adobe Flash runtime without requiring Flash itself.

---

## What this mod changes

### Cheat system — all cheats always available

The original game locked cheats behind save-file progress. This mod calls `setcheats()` unconditionally so **all cheats are available from the very first launch**. Amy and Shadow are also always unlocked in the character select screen. The cheat menu is scrollable (5 per page with PREV/NEXT buttons) to keep the screen uncluttered.

### Cheat 6 — `ALL FLY`

In the original game only Tails and Cream can fly (double-tap Jump while airborne to glide, tap again to flap upward). This cheat extends that ability to every character.

- Tails and Cream retain their native `fly` animation.
- All other characters use the `jumphigh` animation as a visual stand-in while gliding.
- Flying still expires after ~100 frames; land to reset it.

### Cheat 7 — `INFINITE-FLY`

When toggled on alongside `ALL FLY` (or while playing as Tails / Cream), the fly timer is refreshed every frame instead of counting down. The character stays airborne indefinitely. Has no effect unless the current character can fly.

### Cheat 8 — `INVINCIBLE`

`sethit()` returns immediately before applying any damage. The character cannot lose rings, take a hit, or die from enemy contact.

### Cheat 9 — `RING MAGNET`

Loose rings within 200 screen pixels are pulled toward the player each frame. Attraction scales with proximity; ring velocity is capped at 10 px/frame for a smooth glide. Rings still collect normally once they reach the player's hitbox.

### `Q` / `q` / `/` — Quit to menu

Pressing any of these keys during gameplay immediately returns to the main menu (no life deducted).

---

## Ground pound (always-on, no cheat required)

While airborne, press **Down** to ground pound:

- Snaps to fast falling velocity; horizontal speed is cut to 20%.
- Cancels any active fly mode.
- On landing the hitbox expands to 600% for 4 frames, defeating nearby enemies through their own collision code.

---

## How to use the cheats in-game

1. Open the game (see **Playing the mod** below).
2. From the main menu choose **CHEATS**.
3. Toggle any cheats on (use NEXT/PREV to scroll through all 9).
4. Select a character and start a level.

---

## Playing the mod

The output file is `sonic_fly.swf`. Load it with Ruffle:

**Browser extension** — install [Ruffle](https://ruffle.rs/#releases) for Chrome/Firefox, then open `sonic_fly.swf` as a local file (`File → Open File` or drag-and-drop onto a browser tab).

**Ruffle desktop** — download the standalone player from the [Ruffle releases page](https://github.com/ruffle-rs/ruffle/releases) and open `sonic_fly.swf` directly.

---

## Building from source

The mod's ActionScript sources live in `decompiled/scripts/`. The build process uses [JPEXS Free Flash Decompiler (FFDec)](https://github.com/jindrapetrik/jpexs-decompiler) to inject the modified scripts back into the original SWF binary.

### Prerequisites

- Java 11 or later
- FFDec 21.0.1 (`ffdec.jar`) — downloaded automatically by the CI workflow

### Local build

```bash
java -jar /path/to/ffdec.jar \
  -importScript ultimate_sonic.swf sonic_fly.swf \
  decompiled/scripts
```

The original SWF (`ultimate_sonic.swf`) is left untouched; all output goes to `sonic_fly.swf`.

---

## Repository layout

```
.
├── ultimate_sonic.swf   # original, unmodified game binary (source)
├── sonic_fly.swf               # compiled mod output (produced by CI)
├── decompiled/
│   └── scripts/                # modified ActionScript 2 sources
│       ├── frame_290/
│       │   └── DoAction.as                         # cheat registry & setcheats()
│       ├── frame_291/
│       │   └── PlaceObject2_2497_4/
│       │       ├── onClipEvent(load)_2.as           # cheat menu display / scrolling (maxCheat=9)
│       │       └── onClipEvent(load)_3.as           # cheat toggle handler
│       └── frame_327/
│           └── PlaceObject2_2556_25/
│               ├── onClipEvent(load).as             # control functions, animations, ground pound init
│               └── onClipEvent(enterFrame).as       # fly countdown, shockwave, ring magnet
└── .github/
    └── workflows/
        └── build.yml           # CI/CD: recompile SWF and publish as artifact
```

---

## Technical notes

### Decompilation

The SWF was decompiled with `ffdec -export script` into ActionScript 2 (`.as`) files. FFDec preserves the original bytecode structure; `importScript` recompiles only the changed scripts and re-packs them into the SWF.

### Fly mechanic internals

The `fly` variable is an integer (`"off"` when inactive, `100` when first activated). Each game frame it decrements by 1. `setgravity()` divides gravity by 5 whenever `fly != "off"`. `INFINITE-FLY` writes `fly = 100` each frame so the timer never reaches 0.

### Ground pound shockwave

All enemies call `hitTest(_root.Sonic1.hitb)` for player contact detection — there is one shared hitbox clip. Scaling `hitb._xscale/_yscale` to 600% for 4 frames after landing causes every nearby enemy's own per-frame collision check to fire, defeating them without modifying any enemy script.

### Ring magnet coordinates

Loose ring clips (`_root["rl" + n]`) and the player both have their `_x/_y` kept in screen space by the camera system. The distance check in the magnet code works in screen pixels directly — no coordinate conversion needed.

### Why `jumphigh` for non-Tails/Cream characters

Sonic, Knuckles, Amy, and Shadow have no `fly` frame label in their sprite timelines (animations top out at frame 120; Tails and Cream have a dedicated looping `fly` animation at frame 180). `jumphigh` is the closest existing airborne pose available in all character sprites.
