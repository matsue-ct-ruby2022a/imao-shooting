class Enemy2 < Sprite
  def update
    self.y += 1
    if self.y >= 480
      self.vanish
    end
  end
end