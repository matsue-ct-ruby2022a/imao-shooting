class Enemy < Sprite

    def initialize(x, y, image)
      super
      @damage =1
      @enemy_hp = 2
    end

    def move
      self.y += 1
    end

    def hit

      @enemy_hp = @enemy_hp - @damage

      if @enemy_hp <= 0
        self.vanish
      end

    end
  end