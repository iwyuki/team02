class BlockManager {
  Block[] blocks;

  BlockManager() {
    blocks = new Block[19];
    blocks[0]  = new Block(660, groundY - 130);
    blocks[1]  = new Block(700, groundY - 130);
    blocks[2]  = new Block(740, groundY - 130);
    blocks[3]  = new Block(740, groundY - 230);
    blocks[4]  = new Block(780, groundY - 130);
    blocks[5]  = new Block(820, groundY - 130);
    blocks[6]  = new Block(2660, groundY - 130);
    blocks[7]  = new Block(2700, groundY - 130);
    blocks[8]  = new Block(2740, groundY - 130);
    blocks[9]  = new Block(2780, groundY - 260);
    blocks[10] = new Block(2820, groundY - 260);
    blocks[11] = new Block(2860, groundY - 260);
    blocks[12] = new Block(2900, groundY - 260);
    blocks[13] = new Block(2940, groundY - 260);
    blocks[14] = new Block(2980, groundY - 260);
    blocks[15] = new Block(3020, groundY - 260);
    blocks[16] = new Block(3200, groundY - 260);
    blocks[17] = new Block(3240, groundY - 260);
    blocks[18] = new Block(3280, groundY - 260);
  }
}
