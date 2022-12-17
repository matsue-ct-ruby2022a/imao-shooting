class Enemy < Sprite

    def initialize(x, y, image)
      super
      @damage =1
      @hp = 5
    end


    def hit

      @hp = @hp - @damage

      if @hp == 0
        self.vanish
      end

    end
  end