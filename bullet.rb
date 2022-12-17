class Bullet < Sprite

attr_accessor :d #dを外部から読み書きできる

def initialize(playerX, playerY)
    @startX = playerX
    @startY = playerY
    @d = 0
    self.image = BULLET_IMG
end

def move 
    @d += 10
    self.x = @startX
    self.y = @startY - @d
    self.draw
end

def shot
    self.vanish
end

end
