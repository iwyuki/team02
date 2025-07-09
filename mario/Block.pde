class Block {
  float x, y;
  float size = 40;

  Block(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void show(float scroll) {
    fill(200, 150, 0);
    rect(x - scroll, y, size, size);
  }

  void checkCollisionWithResponse() {
    float px = playerX;
    float py = playerY;
    float r = playerSize / 2;

    if (px + r > x && px - r < x + size &&
        py + r > y && py - r < y + size) {

      float overlapLeft = px + r - x;
      float overlapRight = x + size - (px - r);
      float overlapTop = py + r - y;
      float overlapBottom = y + size - (py - r);

      float minOverlap = min(min(overlapLeft, overlapRight), min(overlapTop, overlapBottom));

      if (minOverlap == overlapTop) {
        playerY = y - r;
        playerSpeedY = 0;
        onGround = true;
      } else if (minOverlap == overlapBottom) {
        playerY = y + size + r;
        if (playerSpeedY < 0) playerSpeedY = 0;
      } else if (minOverlap == overlapLeft) {
        playerX = x - r;
        if (playerSpeedX > 0) playerSpeedX = 0;
      } else if (minOverlap == overlapRight) {
        playerX = x + size + r;
        if (playerSpeedX < 0) playerSpeedX = 0;
      }
    }
  }
}
