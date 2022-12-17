class Player < Sprite
  attr_accessor :score # スコア
  attr_accessor :hp # 体力
  attr_accessor :r
  attr_accessor :count
  attr_accessor :dead_flag # 生存判定(0ならarive,1ならdead)
    
  
    def initialize(x, y, image) # 追加
      @score = 0
      @dead_flag = 0
      @hp = 50
      @r = 3
      @count = 0
      super
    end
  
    def move1

      @count += 1

      if  self.x >= 320 and self.x <= 620 and self.y <= 460 and self.y >= 0
        self.x += @r*Input.x
        self.y += @r*Input.y
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

      @count += 1

      if self.x <= 300 and self.x >= 0 and self.y <= 460 and self.y >= 0
        self.x += Input.keyDown?(K_D) ? @r : 0
        self.x -= Input.keyDown?(K_A) ? @r : 0
        self.y += Input.keyDown?(K_S) ? @r : 0
        self.y -= Input.keyDown?(K_W) ? @r : 0
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
  
    def shot(other) # 相手に衝突したとき
      other_name = other.class.to_s

      if other_name == 'Enemy'
        @hp -= 3
        if @hp <= 0
          @dead_flag = 1
        end

      elsif other_name == 'Enemy2'
        @hp -= 1
        if @hp <= 0
          @dead_flag = 1
        end

      elsif other_name == 'Item1'
        @hp += 10

      elsif other_name == 'Item2'
        @count = 0
        @r = 8
      end

    end

    def hit 
      @hp -= 4
      if @hp <= 0
        @dead_flag = 1
      end
    end

    
  end