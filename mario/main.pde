// main.pde

// --- プレイヤー ---
float playerX = 100;
float playerY = 300;
float playerSize = 50;
float playerSpeedX = 0;
float playerSpeedY = 0;
boolean onGround = false;
PImage playerImg;
PImage playerPoweredUpImg;
boolean isPoweredUp = false;
float poweredUpImgOffsetY = -playerSize / 2 - 15;

// --- スクロール ---
float scrollX = 0;
float gravity = 0.8;
float jumpPower = -16;

// --- 地面 ---
float groundY = 350;

// --- 敵・ブロック・ゴール ---
ArrayList<Enemy> enemies;
BlockManager blockManager;
Pipe[] pipes;
QuestionBlock[] qBlocks;
ArrayList<Item> items;
ArrayList<Bullet> bullets;
Boss boss;

float goalX = 4600;
boolean gameClear = false;

// --- 画像ファイル ---
PImage enemyImg1;
PImage enemyImg2;
PImage enemyImg3;
PImage fireFlowerImg;
PImage bossImg;

void setup() {
  size(800, 400);

  enemyImg1 = loadImage("kurosio.png");
  enemyImg2 = loadImage("udonn.png");
  enemyImg3 = loadImage("sudachi.png");
  playerImg = loadImage("emika.png");
  playerPoweredUpImg = loadImage("dango.png");
  bossImg = loadImage("aidaimikyan.png");

  fireFlowerImg = loadImage("dango.png");

  enemies = new ArrayList<Enemy>();
  enemies.add(new Enemy(600, groundY - 65, 50, 600, enemyImg1));
  enemies.add(new Enemy(1200, groundY - 65, 1050, 1330, enemyImg1));
  enemies.add(new Enemy(2000, groundY - 65, 1850, 2060, enemyImg2));
  enemies.add(new Enemy(2050, groundY - 65, 1900, 2110, enemyImg2));
  enemies.add(new Enemy(2110, groundY - 180, 0, 2110, enemyImg3));
  enemies.add(new Enemy(2600, groundY - 130, 0, 2600, enemyImg3));
  enemies.add(new Enemy(1400, groundY - 160, 0, 1400, enemyImg3));

  pipes = new Pipe[4];
  pipes[0] = new Pipe(1000, groundY - 75);
  pipes[1] = new Pipe(1800, groundY - 125);
  pipes[2] = new Pipe(1400, groundY - 100);
  pipes[3] = new Pipe(2200, groundY - 125);

  blockManager = new BlockManager();

  qBlocks = new QuestionBlock[2];
  qBlocks[0] = new QuestionBlock(440, 220, fireFlowerImg);
  qBlocks[1] = new QuestionBlock(2400, 150, fireFlowerImg);

  items = new ArrayList<Item>();
  bullets = new ArrayList<Bullet>();

  boss = new Boss(3600, groundY - 200 / 2, 200, bossImg);
}

void draw() {
  background(135, 206, 235);

  updatePlayer();
  scrollX = playerX - 100;

  imageMode(CENTER);
  image(playerImg, playerX - scrollX, playerY, playerSize, playerSize);
  if (isPoweredUp) {
    image(playerPoweredUpImg, playerX - scrollX, playerY + poweredUpImgOffsetY, 30, 30);
  }

  onGround = false;
  playerSpeedY += gravity;
  playerY += playerSpeedY;

  for (Pipe p : pipes) {
    p.show(scrollX);
    if (p.checkCollisionWithResponse()) {
      onGround = true;
    }
  }

  for (Block b : blockManager.blocks) {
    b.show(scrollX);
    if (b.checkCollisionWithResponse()) {
      onGround = true;
    }
  }

  for (QuestionBlock qb : qBlocks) {
    qb.show(scrollX);
    if (qb.checkCollisionWithPlayer()) {
      if (qb.isHit() && !qb.hasItemSpawned()) {
        items.add(new Item(qb.x + qb.size / 2, qb.y - qb.size / 2, fireFlowerImg));
        qb.setItemSpawned(true);
      }
      if (playerY < qb.y && playerY + playerSize / 2 >= qb.y) {
        onGround = true;
      }
    }
  }

  for (int i = items.size() - 1; i >= 0; i--) {
    Item item = items.get(i);
    item.update();
    item.show(scrollX);
    if (item.checkCollisionWithPlayer()) {
      isPoweredUp = true;
      items.remove(i);
    }
  }

  for (int i = bullets.size() - 1; i >= 0; i--) {
    Bullet b = bullets.get(i);
    b.update();
    b.show(scrollX);

    if (b.x - scrollX < -50 || b.x - scrollX > width + 50) {
      bullets.remove(i);
      continue;
    }

    boolean bulletHitEnemy = false;
    for (int j = enemies.size() - 1; j >= 0; j--) {
      Enemy e = enemies.get(j);
      if (b.checkCollisionWithEnemy(e)) {
        enemies.remove(j);
        bullets.remove(i);
        bulletHitEnemy = true;
        break;
      }
    }
    if (bulletHitEnemy) continue;

    boolean bulletHitBlock = false;
    for (Block bl : blockManager.blocks) {
      if (b.checkCollisionWithBlock(bl.x, bl.y, bl.size)) {
        bullets.remove(i);
        bulletHitBlock = true;
        break;
      }
    }
    if (bulletHitBlock) continue;

    boolean bulletHitQBlock = false;
    for (QuestionBlock qb : qBlocks) {
      if (b.checkCollisionWithBlock(qb.x, qb.y, qb.size)) {
        bullets.remove(i);
        bulletHitQBlock = true;
        break;
      }
    }
    if (bulletHitQBlock) continue;

    boolean bulletHitPipe = false;
    for (Pipe p : pipes) {
      if (b.x + b.size/2 > p.x - p.width/2 && b.x - b.size/2 < p.x + p.width/2 &&
          b.y + b.size/2 > p.y && b.y - b.size/2 < p.y + p.pipeHeight) {
        bullets.remove(i);
        bulletHitPipe = true;
        break;
      }
    }
    if (bulletHitPipe) continue;

    if (playerX > 3000 && !boss.isDefeated()) {
      if (dist(b.x, b.y, boss.x, boss.y) < (b.size / 2) + (boss.size / 2)) {
        boss.takeDamage();
        bullets.remove(i);
        continue;
      }
    }
  }

  fill(50, 200, 70);
  rect(-scrollX, groundY, 2400, height - groundY);
  rect(2500 - scrollX, groundY, 340, height - groundY);
  rect(3040 - scrollX, groundY, 2000, height - groundY);

  boolean onSolidGroundArea = (playerX >= 0 && playerX <= 2400) || (playerX >= 2500 && playerX <= 2840) || (playerX >= 3040 && playerX <= 5040);

  if (playerY + playerSize / 2 >= groundY) {
    if (onSolidGroundArea) {
      playerY = groundY - playerSize / 2;
      playerSpeedY = 0;
      onGround = true;
    }
  }

  if (playerY + playerSize / 2 - 100 > height) {
    println("ゲームオーバー！（落下）");
    restartGame();
  }

  for (int i = enemies.size() - 1; i >= 0; i--) {
    Enemy e = enemies.get(i);
    e.move();
    e.show(scrollX);
    if (e.checkCollision(playerX, playerY, playerSize)) {
      println("ゲームオーバー！");
      restartGame();
    }
  }

  if (!boss.isDefeated()) {
    boss.update(playerX, playerY);

    boolean bossOnPipe = false;
    for (Pipe p : pipes) {
      if (boss.checkCollisionWithPipe(p)) {
        bossOnPipe = true;
        break;
      }
    }

    for (int i = boss.bossBullets.size() - 1; i >= 0; i--) {
      BossBullet bb = boss.bossBullets.get(i);
      bb.update();

      if (bb.checkCollisionWithPlayer(playerX, playerY, playerSize)) {
        boss.bossBullets.remove(i); // 先に削除
        println("ゲームオーバー！ (ボスの弾に被弾)");
        restartGame();              // その後リスタート
        continue;
      }
      if (bb.isOffScreen(scrollX)) {
        boss.bossBullets.remove(i);
        continue;
      }
    }

    boss.show(scrollX);
  }

  fill(255);
  rect(goalX - scrollX, groundY - 330, 10, 330);
  fill(255, 0, 0);
  ellipse(goalX - scrollX + 5, groundY - 330, 20, 20);

  if (playerX >= goalX) {
      fill(0, 0, 0, 180);
      textSize(40);
      text("CLEAR!", width / 2 - 80, height / 2);
      gameClear = true;
      noLoop();
  }
}

void updatePlayer() {
  playerX += playerSpeedX;
}

void keyPressed() {
  if (keyCode == RIGHT) {
    playerSpeedX = 5;
  } else if (keyCode == LEFT) {
    playerSpeedX = -5;
  } else if (key == ' ' && onGround) {
    playerSpeedY = jumpPower;
    onGround = false;
  } else if (key == 'z' || key == 'Z') {
    if (isPoweredUp) {
      float bulletSpeed = 10;
      float bulletDir = (playerSpeedX >= 0) ? 1 : -1;
      if (playerSpeedX == 0) bulletDir = 1;
      bullets.add(new Bullet(playerX + bulletDir * playerSize / 2, playerY, bulletSpeed * bulletDir));
    }
  }
}

void keyReleased() {
  if (keyCode == RIGHT || keyCode == LEFT) {
    playerSpeedX = 0;
  }
}

void restartGame() {
  playerX = 100;
  playerY = 300;
  playerSpeedX = 0;
  playerSpeedY = 0;
  onGround = false;
  isPoweredUp = false;
  gameClear = false;

  enemies = new ArrayList<Enemy>();
  enemies.add(new Enemy(600, groundY - 65, 50, 600, enemyImg1));
  enemies.add(new Enemy(1200, groundY - 65, 1050, 1330, enemyImg1));
  enemies.add(new Enemy(2000, groundY - 65, 1850, 2060, enemyImg2));
  enemies.add(new Enemy(2050, groundY - 65, 1900, 2110, enemyImg2));
  enemies.add(new Enemy(2110, groundY - 180, 0, 2110, enemyImg3));
  enemies.add(new Enemy(2600, groundY - 130, 0, 2600, enemyImg3));
  enemies.add(new Enemy(1400, groundY - 160, 0, 1400, enemyImg3));

  qBlocks[0] = new QuestionBlock(440, 220, fireFlowerImg);
  qBlocks[1] = new QuestionBlock(2400, 150, fireFlowerImg);

  items.clear();
  bullets.clear();
  boss = new Boss(3600, groundY - 200 / 2, 200, bossImg);

  loop();
}

void mousePressed() {
  if (!gameClear) loop();
}
