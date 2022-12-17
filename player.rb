class Player < Sprite
  attr_accessor :score # スコア
  attr_accessor :hp # 体力
  
  attr_accessor :dead_flag # 生存判定(0ならarive,1ならdead)
    
  
    def initialize(x, y, image) # 追加
      @score = 0
      @dead_flag = 0
      @hp = 100
      super
    end
  
    def move1
      if  self.x >= 320 and self.x <= 620 and self.y <= 460 and self.y >= 0
        self.x += 3*Input.x
        self.y += 3*Input.y
      elsif self.x < 320
        self.x = 320
      elsif self.x > 620
        self.x = 620
      elsif self.y > 460
        self.y = 460
      elsif self.y < 0
        self.y = 0
      end
    end

    def move2

      if self.x <= 300 and self.x >= 0 and self.y <= 460 and self.y >= 0
        self.x += Input.keyDown?(K_D) ? 3 : 0
        self.x -= Input.keyDown?(K_A) ? 3 : 0
        self.y += Input.keyDown?(K_S) ? 3 : 0
        self.y -= Input.keyDown?(K_W) ? 3 : 0
      elsif self.x > 300
        self.x = 300
      elsif self.x < 0
        self.x = 0
      elsif self.y > 460
        self.y = 460
      elsif self.y < 0
        self.y = 0
      end

    
    end
  
    def shot # 相手に衝突したとき
      @hp -= 1
      if @hp <= 0
        @dead_flag = 1
      end
    end
    
  end