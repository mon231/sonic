import math, os
from PIL import Image, ImageDraw, ImageFilter, ImageChops

OUT = r"C:\Users\avart\Desktop\sonic_remake\resources"
os.makedirs(OUT, exist_ok=True)

CORAL   = (217, 119, 87, 255)   # Anthropic clay/coral #D97757
CORAL_D = (171, 82, 55, 255)
CORAL_L = (236, 162, 132, 255)

def save(img, name):
    p = os.path.join(OUT, name)
    img.save(p)
    print(name, img.size, os.path.getsize(p), "bytes")

# ---------- claude.png / claude_sad.png : coral sunburst mascot (256x256) ----------
def make_claude(mood="happy"):
    S = 512
    img = Image.new("RGBA", (S, S), (0, 0, 0, 0))
    d = ImageDraw.Draw(img)
    cx, cy = S / 2.0, S / 2.0
    rout, rin = S * 0.46, S * 0.30
    rays = 12
    for i in range(rays):
        a = (i / rays) * 2 * math.pi
        tx, ty = cx + rout * math.cos(a), cy + rout * math.sin(a)
        a1, a2 = a - 0.135, a + 0.135
        b1 = (cx + rin * math.cos(a1), cy + rin * math.sin(a1))
        b2 = (cx + rin * math.cos(a2), cy + rin * math.sin(a2))
        d.polygon([b1, (tx, ty), b2], fill=CORAL)
    d.ellipse([cx - rin, cy - rin, cx + rin, cy + rin], fill=CORAL)
    hr = rin * 0.78
    d.ellipse([cx - hr, cy - hr * 1.05, cx + hr, cy + hr * 0.92], fill=CORAL_L)
    d.ellipse([cx - rin, cy - rin, cx + rin, cy + rin], outline=CORAL_D, width=int(S * 0.013))
    sad = mood == "sad"
    # eyes
    ew, eh = S * 0.105, S * 0.135
    ex = S * 0.130
    ey = cy - S * 0.045
    for sx in (-1, 1):
        x0 = cx + sx * ex - ew / 2
        y0 = ey - eh / 2
        d.ellipse([x0, y0, x0 + ew, y0 + eh], fill=(255, 255, 255, 255), outline=CORAL_D, width=int(S * 0.007))
        pw = ew * 0.52
        pdy = eh * 0.30 if sad else eh * 0.10   # sad: pupils look down
        px = x0 + ew / 2 - pw / 2 + sx * ew * 0.05
        py = y0 + eh / 2 - pw / 2 + pdy
        d.ellipse([px, py, px + pw, py + pw], fill=(58, 38, 32, 255))
        d.ellipse([px + pw * 0.16, py + pw * 0.10, px + pw * 0.46, py + pw * 0.40], fill=(255, 255, 255, 235))
    smw = S * 0.155
    if sad:
        # worried eyebrows: inner ends raised, outer ends low
        for sx in (-1, 1):
            inx, iny = cx + sx * ex * 0.42, ey - eh * 1.02
            oux, ouy = cx + sx * ex * 1.5, ey - eh * 0.52
            d.line([(inx, iny), (oux, ouy)], fill=CORAL_D, width=int(S * 0.024))
        # frown: downward mouth (top-arc ∩ shape)
        d.arc([cx - smw, cy + S * 0.135, cx + smw, cy + S * 0.135 + S * 0.17],
              start=205, end=335, fill=CORAL_D, width=int(S * 0.020))
        save(img.resize((256, 256), Image.LANCZOS), "claude_sad.png")
    else:
        # smile
        d.arc([cx - smw, cy + S * 0.045, cx + smw, cy + S * 0.045 + S * 0.16],
              start=20, end=160, fill=CORAL_D, width=int(S * 0.018))
        save(img.resize((256, 256), Image.LANCZOS), "claude.png")

# ---------- fire.png : layered flame (160x256) ----------
def make_fire():
    W, H = 320, 512
    img = Image.new("RGBA", (W, H), (0, 0, 0, 0))
    d = ImageDraw.Draw(img)
    cx = W / 2.0
    def flame(scale, color):
        n = 28
        pts = []
        for i in range(n + 1):
            tt = i / n
            y = H * (1 - tt)
            base = (W * 0.44 * scale) * ((1 - tt) ** 0.55) * (0.55 + 0.55 * math.sin(tt * math.pi))
            wob = math.sin(tt * 9.0) * (W * 0.035 * scale) * tt
            pts.append((cx - base + wob * 0.3, y))
        for i in range(n + 1):
            tt = 1 - i / n
            y = H * (1 - tt)
            base = (W * 0.44 * scale) * ((1 - tt) ** 0.55) * (0.55 + 0.55 * math.sin(tt * math.pi))
            wob = math.sin(tt * 9.0) * (W * 0.035 * scale) * tt
            pts.append((cx + base + wob * 0.3, y))
        d.polygon(pts, fill=color)
    flame(1.0, (236, 110, 52, 235))
    flame(0.70, (248, 170, 60, 245))
    flame(0.40, (255, 240, 185, 255))
    img = img.filter(ImageFilter.GaussianBlur(3))
    img = img.resize((160, 256), Image.LANCZOS)
    save(img, "fire.png")

# ---------- tired.png : sweat drops (128x128) ----------
def make_tired():
    S = 256
    img = Image.new("RGBA", (S, S), (0, 0, 0, 0))
    d = ImageDraw.Draw(img)
    BLUE = (96, 168, 232, 245)
    EDGE = (40, 96, 168, 255)
    def drop(cx, cy, r):
        o = r * 0.16  # outline thickness
        # dark edge (drawn slightly larger first)
        d.ellipse([cx - r - o, cy - r - o, cx + r + o, cy + r + o], fill=EDGE)
        d.polygon([(cx - (r + o) * 0.72, cy - r * 0.25), (cx, cy - r * 2.35), (cx + (r + o) * 0.72, cy - r * 0.25)], fill=EDGE)
        # blue body
        d.ellipse([cx - r, cy - r, cx + r, cy + r], fill=BLUE)
        d.polygon([(cx - r * 0.72, cy - r * 0.25), (cx, cy - r * 2.2), (cx + r * 0.72, cy - r * 0.25)], fill=BLUE)
        d.ellipse([cx - r * 0.5, cy - r * 0.55, cx - r * 0.02, cy - r * 0.05], fill=(255, 255, 255, 230))
    drop(S * 0.50, S * 0.58, S * 0.17)
    drop(S * 0.76, S * 0.45, S * 0.11)
    drop(S * 0.28, S * 0.43, S * 0.095)
    img = img.filter(ImageFilter.GaussianBlur(1))
    img = img.resize((128, 128), Image.LANCZOS)
    save(img, "tired.png")

# ---------- puff.png : soft dust cloud (160x128) ----------
def make_puff():
    W, H = 320, 256
    img = Image.new("RGBA", (W, H), (0, 0, 0, 0))
    d = ImageDraw.Draw(img)
    CREAM = (239, 234, 225, 220)
    blobs = [(0.5, 0.62, 0.30), (0.30, 0.56, 0.22), (0.70, 0.56, 0.22),
             (0.42, 0.42, 0.17), (0.60, 0.42, 0.17), (0.50, 0.72, 0.19),
             (0.20, 0.64, 0.13), (0.82, 0.62, 0.13)]
    for bx, by, br in blobs:
        cx, cy, r = bx * W, by * H, br * H
        d.ellipse([cx - r, cy - r, cx + r, cy + r], fill=CREAM)
    img = img.filter(ImageFilter.GaussianBlur(6))
    img = img.resize((160, 128), Image.LANCZOS)
    save(img, "puff.png")

# ---------- streak.png : symmetric speed lines (256x100) ----------
def make_streak():
    W, H = 512, 200
    img = Image.new("RGBA", (W, H), (0, 0, 0, 0))
    d = ImageDraw.Draw(img)
    cols = [(255, 255, 255, 205), (236, 162, 132, 205), (255, 255, 255, 175)]
    rows = [(0.24, 0.78, 0.05), (0.40, 0.95, 0.07), (0.52, 0.62, 0.045),
            (0.64, 0.88, 0.06), (0.80, 0.50, 0.04)]
    for i, (yf, Lf, thf) in enumerate(rows):
        y = yf * H
        L = W * Lf
        x0 = (W - L) / 2
        th = H * thf
        col = cols[i % 3]
        d.polygon([(x0, y), (x0 + L * 0.5, y - th / 2), (x0 + L, y), (x0 + L * 0.5, y + th / 2)], fill=col)
    img = img.filter(ImageFilter.GaussianBlur(2))
    img = img.resize((256, 100), Image.LANCZOS)
    save(img, "streak.png")

# ---------- cry.png : streaming tears from the eyes (128x128 face overlay) ----------
def make_cry():
    S = 256
    img = Image.new("RGBA", (S, S), (0, 0, 0, 0))
    d = ImageDraw.Draw(img)
    BLUE = (108, 182, 240, 235)
    EDGE = (52, 120, 198, 255)
    cx = S / 2.0
    ex = 0.130 * S          # eye x offset (matches claude.png eyes)
    ey = cx - 0.045 * S     # eye y (~0.455 of height)
    for sx in (-1, 1):
        x = cx + sx * ex
        top = ey + S * 0.02
        bot = ey + S * 0.46
        wt, wb = S * 0.030, S * 0.075
        # dark edge then blue body of the stream (widens downward, rounded tip)
        d.polygon([(x - wt - 2, top), (x + wt + 2, top), (x + wb + 2, bot - wb), (x, bot + 3), (x - wb - 2, bot - wb)], fill=EDGE)
        d.polygon([(x - wt, top), (x + wt, top), (x + wb, bot - wb), (x, bot), (x - wb, bot - wb)], fill=BLUE)
        d.ellipse([x - wb * 0.55, bot - wb * 1.7, x - wb * 0.02, bot - wb * 0.6], fill=(255, 255, 255, 220))
        # a detached falling droplet lower down
        dy = bot + S * 0.12
        d.ellipse([x - wb, dy - wb, x + wb, dy + wb], fill=EDGE)
        d.ellipse([x - wb * 0.78, dy - wb * 0.78, x + wb * 0.78, dy + wb * 0.78], fill=BLUE)
        d.polygon([(x - wb * 0.6, dy - wb * 0.4), (x, dy - wb * 1.9), (x + wb * 0.6, dy - wb * 0.4)], fill=BLUE)
        d.ellipse([x - wb * 0.45, dy - wb * 0.45, x - wb * 0.02, dy], fill=(255, 255, 255, 210))
    img = img.filter(ImageFilter.GaussianBlur(1))
    img = img.resize((128, 128), Image.LANCZOS)
    save(img, "cry.png")

# ---------- claude_ball.png : coral spin-ball (curved-ray pinwheel) for roll/jump (256x256) ----------
def make_ball():
    SS, OUTP = 1024, 256
    cx = cy = SS / 2.0
    R = SS / 2.0 - 18
    img = Image.new("RGBA", (SS, SS), (0, 0, 0, 0))
    d = ImageDraw.Draw(img)
    d.ellipse([cx - R, cy - R, cx + R, cy + R], fill=CORAL)
    # curved swept spokes -> a pinwheel that visibly spins when the sprite is rotated
    N = 12
    twist = 1.0                       # radians each spoke sweeps from center to rim
    ww = (2 * math.pi / N) * 0.60     # angular width of each spoke
    steps = 26
    for i in range(N):
        a0 = (i / N) * 2 * math.pi
        col = CORAL_D if i % 2 == 0 else CORAL_L
        pts = []
        for s in range(steps + 1):
            rr = R * (s / steps); ang = a0 + twist * (s / steps)
            pts.append((cx + rr * math.cos(ang), cy + rr * math.sin(ang)))
        for s in range(steps, -1, -1):
            rr = R * (s / steps); ang = a0 + ww + twist * (s / steps)
            pts.append((cx + rr * math.cos(ang), cy + rr * math.sin(ang)))
        d.polygon(pts, fill=col)
    # round mask
    mask = Image.new("L", (SS, SS), 0)
    ImageDraw.Draw(mask).ellipse([cx - R, cy - R, cx + R, cy + R], fill=255)
    img.putalpha(mask)
    # spherical radial shading (multiply), light from upper-left
    shade = Image.new("L", (SS, SS), 0)
    sh = shade.load()
    lcx, lcy = cx - R * 0.30, cy - R * 0.30
    step = 2
    for y in range(0, SS, step):
        for x in range(0, SS, step):
            t = min(1.0, math.hypot(x - lcx, y - lcy) / (R * 1.7))
            v = int(255 * (1.0 - 0.40 * (t ** 1.4)))
            for yy in range(y, min(y + step, SS)):
                for xx in range(x, min(x + step, SS)):
                    sh[xx, yy] = v
    r, g, b, a = img.split()
    rgb = ImageChops.multiply(Image.merge("RGB", (r, g, b)), Image.merge("RGB", (shade, shade, shade)))
    r, g, b = rgb.split()
    img = Image.merge("RGBA", (r, g, b, a))
    # soft white specular highlight upper-left
    hi = Image.new("RGBA", (SS, SS), (0, 0, 0, 0))
    hlr = R * 0.30
    hcx, hcy = cx - R * 0.34, cy - R * 0.34
    ImageDraw.Draw(hi).ellipse([hcx - hlr, hcy - hlr, hcx + hlr, hcy + hlr], fill=(255, 255, 255, 200))
    hi = hi.filter(ImageFilter.GaussianBlur(SS // 22))
    hr, hg, hb, ha = hi.split()
    ha = ImageChops.multiply(ha, mask)
    hi = Image.merge("RGBA", (hr, hg, hb, ha))
    img = Image.alpha_composite(img, hi)
    save(img.resize((OUTP, OUTP), Image.LANCZOS), "claude_ball.png")

make_claude("happy")
make_claude("sad")
make_ball()
make_puff()
make_streak()
print("DONE ->", OUT)
