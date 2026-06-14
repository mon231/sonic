# Ultimate Sonic Flash — Modded

A community mod of the classic *Ultimate Sonic* Flash game, adding quality-of-life cheats including universal flying and an infinite-fly mode for all characters.

The original game was published on Newgrounds and is now copyright-free. Flash games are run today via the [Ruffle](https://ruffle.rs/) browser extension or desktop player, which emulates the Adobe Flash runtime without requiring Flash itself.

---

## What this mod changes

### Cheat system — all cheats always available

The original game locked cheats behind save-file progress (you had to complete zones with every character to unlock each one). This mod calls `setcheats()` unconditionally so **all cheats are available from the very first launch**, no progress required. Amy and Shadow are also always unlocked in the character select screen.

### Cheat 6 — `ALL FLY`

In the original game only Tails and Cream can fly (double-tap Jump while airborne to glide, tap again to flap upward). This cheat extends that ability to every character — Sonic, Knuckles, Amy, and Shadow included.

- Tails and Cream retain their native `fly` animation.
- All other characters use the `jumphigh` animation as a visual stand-in while gliding.
- Flying still expires after ~100 frames; land to reset it.

### Cheat 7 — `INFINITE-FLY`

When toggled on alongside `ALL FLY` (or while playing as Tails / Cream), the fly timer is refreshed to `100` every game frame instead of counting down. The character stays airborne indefinitely and can keep tapping Jump to gain height. Flying still ends the moment the character touches the ground.

> `INFINITE-FLY` has no effect unless the current character can fly — either because `ALL FLY` is active, or because the selected character is Tails or Cream.

---

## How to use the cheats in-game

1. Open the game (see **Playing the mod** below).
2. From the main menu choose **CHEATS**.
3. Toggle **ALL FLY: ON** (and optionally **INFINITE-FLY: ON**).
4. Select a character and start a level.
5. Jump, then press Jump again mid-air to begin flying.

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
  -importScript 151706_ultimate_sonic.swf sonic_fly.swf \
  decompiled/scripts
```

The original SWF (`151706_ultimate_sonic.swf`) is left untouched; all output goes to `sonic_fly.swf`.

---

## Repository layout

```
.
├── 151706_ultimate_sonic.swf   # original, unmodified game binary (source)
├── sonic_fly.swf               # compiled mod output (produced by CI)
├── decompiled/
│   └── scripts/                # modified ActionScript 2 sources
│       ├── frame_290/
│       │   └── DoAction.as                         # cheat registry & setcheats()
│       ├── frame_291/
│       │   └── PlaceObject2_2497_4/
│       │       ├── onClipEvent(load)_2.as           # cheat menu display (sentinel bump 7→8)
│       │       └── onClipEvent(load)_3.as           # cheat toggle handler
│       └── frame_327/
│           └── PlaceObject2_2556_25/
│               ├── onClipEvent(load).as             # control_a(), animations(), setgravity()
│               └── onClipEvent(enterFrame).as       # per-frame fly countdown / infinite-fly reset
└── .github/
    └── workflows/
        └── build.yml           # CI/CD: recompile SWF and publish as artifact
```

---

## Technical notes

### Decompilation

The SWF was decompiled with `ffdec -export script` into ActionScript 2 (`.as`) files. FFDec preserves the original bytecode structure; `importScript` recompiles only the changed scripts and re-packs them into the SWF.

### Fly mechanic internals

The `fly` variable is an integer (`"off"` when inactive, `100` when first activated). Each game frame it decrements by 1 while the fly animation is playing. `setgravity()` divides gravity by 5 whenever `fly != "off"`, giving the floaty feel. `control_a()` allows an upward velocity boost (`y += 1`) on each Jump press while `fly > 0`.

`INFINITE-FLY` works by writing `fly = 100` each frame inside the countdown block, so the timer never reaches 0 and the boost window never closes.

### Why `jumphigh` for non-Tails/Cream characters

Sonic, Knuckles, Amy, and Shadow have no `fly` frame label in their sprite timelines (their animations top out at frame 120, whereas Tails and Cream have a dedicated looping `fly` animation at frame 180). `jumphigh` is the closest existing airborne pose available in all character sprites.
