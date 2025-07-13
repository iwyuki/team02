// Pipe.pde

class Pipe {
  float x, y;
  float width = 40;
  float pipeHeight = 2000;  // 固定の高さ
  float capHeight = 15;

  Pipe(float x, float y) {
    this.x = x;
    this.y = y;  // 明示的に配置位置を指定
  }

  void show(float scroll) {
    float sx = x - scroll;

    // 本体部分（下）
    fill(0, 200, 0);
    rect(sx, y + capHeight, width, pipeHeight - capHeight);

    // フチ部分（上）
    fill(0, 180, 0);
    rect(sx - 10, y, width + 20, capHeight);
  }

  boolean checkCollisionWithResponse() {
    float px = playerX;
    float py = playerY;
    float r = playerSize / 2;
    boolean landed = false;

    float topY = y;

    if (px + r > x && px - r < x + width &&
        py + r > topY && py - r < topY + pipeHeight) {

      float overlapLeft = px + r - x;
      float overlapRight = x + width - (px - r);
      float overlapTop = py + r - topY;
      float overlapBottom = topY + pipeHeight - (py - r);

      float minOverlap = min(min(overlapLeft, overlapRight), min(overlapTop, overlapBottom));

      if (minOverlap == overlapTop) {
        playerY = topY - r;
        playerSpeedY = 0;
        landed = true;
      } else if (minOverlap == overlapBottom) {
        playerY = topY + pipeHeight + r;
        if (playerSpeedY < 0) playerSpeedY = 0;
      } else if (minOverlap == overlapLeft) {
        playerX = x - r;
        if (playerSpeedX > 0) playerSpeedX = 0;
      } else if (minOverlap == overlapRight) {
        playerX = x + width + r;
        if (playerSpeedX < 0) playerSpeedX = 0;
      }
    }

    return landed;
  }
}
