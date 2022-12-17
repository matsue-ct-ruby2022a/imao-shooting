class Bullet < Sprite

def initialize(playerX, playerY)
    @startX = playerX
    @startY = playerY
    @d1 = 0
    @d2 = 0
    self.image = BULLET_IMG
end

def move1
    @d1 += 10
    self.x = @startX - @d1
    self.y = @startY
    self.draw
end

def move2
    @d2 += 10
    self.x = @startX + @d2
    self.y = @startY 
    self.draw
end

def shot
    self.vanish
end

end
