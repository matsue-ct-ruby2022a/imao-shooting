class Item1 < Sprite

    def hit
      self.vanish
    end

    def update
      self.y += 1
      if self.y >= 480
        self.vanish
      end
    end
    
  end