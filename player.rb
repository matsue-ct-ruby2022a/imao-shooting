class Player < Sprite
  attr_accessor :score # スコア
  attr_accessor :hp # 体力
  attr_accessor :hit_cont # 連続的に衝突が発生するかのフラグ
  attr_accessor :hit_flag # 衝突が発生するかのフラグ
  
  attr_accessor :dead_flag # 生存判定(0ならarive,1ならdead)
    
  
    def initialize(x, y, image) # 追加
      @score = 0
      @dead_flag = 0
      @hp = 5
      @hit_cont = 0
      super
    end
  
    def update
      self.x += 3*Input.x
      self.y += 3*Input.y
    end
  
    def shot # 相手に衝突したとき
      @hit_flag = 1

      if @hit_cont >= 500 # 連続判定がなければ体力低下
        @hp -= 1
        if @hp <= 0
          @dead_flag = 1

        end
        @hit_cont = 0   # 連続判定をなくす

      end
    end
    
  end