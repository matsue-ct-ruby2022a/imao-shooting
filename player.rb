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
  
    def update
      self.x += 3*Input.x
      self.y += 3*Input.y
    end
  
    def shot # 相手に衝突したとき
      @hp -= 1
      if @hp <= 0
        @dead_flag = 1
      end
    end
    
  end