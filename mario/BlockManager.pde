// BlockManager.pde

class BlockManager {
  Block[] blocks;

  BlockManager() {
    blocks = new Block[48];
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
    blocks[19] = new Block(3280, groundY - 130);
    blocks[20] = new Block(4100, groundY - 40);
    blocks[21] = new Block(4140, groundY - 40);
    blocks[22] = new Block(4140, groundY - 80);
    blocks[23] = new Block(4180, groundY - 40);
    blocks[24] = new Block(4180, groundY - 80);
    blocks[25] = new Block(4180, groundY - 120);
    blocks[26] = new Block(4220, groundY - 40);
    blocks[27] = new Block(4220, groundY - 80);
    blocks[28] = new Block(4220, groundY - 120);
    blocks[29] = new Block(4220, groundY - 160);
    blocks[30] = new Block(4260, groundY - 40);
    blocks[31] = new Block(4260, groundY - 80);
    blocks[32] = new Block(4260, groundY - 120);
    blocks[33] = new Block(4260, groundY - 160);
    blocks[34] = new Block(4260, groundY - 200);
    blocks[35] = new Block(4300, groundY - 40);
    blocks[36] = new Block(4300, groundY - 80);
    blocks[37] = new Block(4300, groundY - 120);
    blocks[38] = new Block(4300, groundY - 160);
    blocks[39] = new Block(4300, groundY - 200);
    blocks[40] = new Block(4300, groundY - 240);
    blocks[41] = new Block(4340, groundY - 40);
    blocks[42] = new Block(4340, groundY - 80);
    blocks[43] = new Block(4340, groundY - 120);
    blocks[44] = new Block(4340, groundY - 160);
    blocks[45] = new Block(4340, groundY - 200);
    blocks[46] = new Block(4340, groundY - 240);
    blocks[47] = new Block(4340, groundY - 280);
    
    
  }
}
