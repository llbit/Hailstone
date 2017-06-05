void setup() {
  size(480, 800);
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

void drawVal(int value, int y) {
  for (int i = 31; i >= 0; i -= 1) {
    if ((value & (1 << i)) != 0) {
      rect(320 - 10 * i, 10 + 10 * y, 10, 10);
    }
  }
}

void draw() {
  clear();
  int value = 2 * (start + int(millis() / 200));
  int y = 0;
  while (value != 1) {
    drawVal(value, y++);
    value = value >> ctz(value);
    if (value == 1) {
      break;
    }
    value = ((value << 1) | 1) + value;
  }
}
