// QuestionBlock.pde

class QuestionBlock {
  float x, y;
  float size = 40; // ブロックのサイズ
  boolean hit = false; // 叩かれたかどうかのフラグ
  boolean itemSpawned = false; // アイテムが生成されたかどうかのフラグ
  PImage itemImg;   // 出現させるアイテムの画像（Itemクラスに渡すため）

  // コンストラクタからPImageの引数を削除
  QuestionBlock(float x, float y, PImage item) {
    this.x = x;
    this.y = y;
    this.itemImg = item;
  }

  void show(float scroll) {
    if (!hit) {
      fill(255, 200, 0); // 黄色 (ハテナブロック通常時)
    } else {
      fill(150, 100, 0); // 茶色 (叩かれた後)
    }
    rect(x - scroll, y, size, size); // 四角形を描画
  }

  // プレイヤーがハテナブロックと衝突したか判定
  boolean checkCollisionWithPlayer() {
    float px = playerX;
    float py = playerY;
    float pr = playerSize / 2;

    // プレイヤーとブロックの矩形衝突判定
    if (px + pr > x && px - pr < x + size &&
        py + pr > y && py - pr < y + size) {

      // 下から叩かれた場合
      if (playerSpeedY < 0 && py + pr > y + size/2 && py - pr < y + size) {
        if (!hit) {
          hit = true; // 叩かれた状態にする
          // 叩かれたらプレイヤーをブロックの下に押し戻す
          playerY = y + size + pr;
          playerSpeedY = 0; // 速度もリセット
        }
      }
      // 上から乗った場合 (着地判定のため)
      else if (playerSpeedY >= 0 && py + pr <= y + playerSpeedY + size && py + pr >= y) {
        playerY = y - pr;
        playerSpeedY = 0;
        return true; // 上に乗った場合も衝突とみなす
      }
      return true; // 衝突している
    }
    return false; // 衝突していない
  }

  boolean isHit() {
    return hit;
  }

  boolean hasItemSpawned() {
    return itemSpawned;
  }

  void setItemSpawned(boolean spawned) {
    this.itemSpawned = spawned;
  }
}
