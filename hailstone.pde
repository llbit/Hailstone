void setup() {
  size(480, 800);
  surface.setResizable(true);
}

// Count trailing zeroes.
int ctz(int v) {
   if ((v & 0x1) != 0) {
     return 0;
   } else {
     int c = 1;
     if ((v & 0xffff) == 0) {
         v >>= 16;
         c += 16;
     }
     if ((v & 0xff) == 0) {
       v >>= 8;
       c += 8;
     }
     if ((v & 0xf) == 0) {
       v >>= 4;
       c += 4;
     }
     if ((v & 0x3) == 0) {
       v >>= 2;
       c += 2;
     }
     return c - (v & 0x1);
   }
}

int start = int(random(16000));

int YMAX = 200;
int[][] pixels = new int[200][32];

void drawVal(int value, int y) {
  for (int i = 31; i >= 0; i -= 1) {
    if ((value & (1 << i)) != 0) {
      pixels[y][i] = 255;
    }
  }
}

int steps(int value) {
  int steps = 0;
  while (value != 1) {
    steps += 1;
    value = value >> ctz(value);
    if (value == 1) {
      break;
    }
    value = ((value << 1) | 1) + value;
  }
  return steps;
}

void draw() {
  clear();
  int value = 2 * (start + int(millis() / 200));
  textSize(15);
  fill(0, 200, 200, 200);
  text(str(value), 50, 20);
  int steps = steps(value);
  for (int y = 0; y < steps; ++y) {
    if (value == 1) {
      break;
    }
    if (steps - y < YMAX) {
      drawVal(value, steps - y);
    }
    value = value >> ctz(value);
    if (value == 1) {
      break;
    }
    value = ((value << 1) | 1) + value;
  }
  for (int y = 0; y < YMAX; ++y) {
    for (int x = 0; x < 32; ++x) {
      if (pixels[y][x] > 0) {
        int c = pixels[y][x];
        fill(color(c, c, c));
        rect(320 - 10 * x, 10 + 10 * y, 10, 10);
        pixels[y][x] -= 80;
      }
    }
  }
}
