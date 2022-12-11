require 'dxruby'

require_relative 'player'
require_relative 'enemy'
require_relative 'bullet'

font = Font.new(32) # 追加
fontL = Font.new(64) # 追加
player_img = Image.load("image/player.png")
enemy_img = Image.load("image/enemy.png")
enemy2_img = Image.load("image/enemy2.png")
BULLET_IMG = Image.load('image/enemyshot1.png')

count = 0

player = Player.new(100, 100, player_img)
enemies = [] #敵1
enemies2 = [] #敵2
bullets1 = [] #弾
bullets2 = [] #弾
50.times do
  enemies << Enemy.new(rand(0..(640 - 32 - 1)), rand((480 - 32 - 1)), enemy_img)  # 敵描画
  enemies2 << Enemy.new(rand(0..(640 - 32 - 1)), rand((480 - 32 - 1)), enemy2_img)  # 敵描画
end

Window.loop do
  player.update
  player.draw

  if Input.key_push?(K_SPACE)

    bullets1 << Bullet.new(player.x, player.y)

  elsif Input.key_down?(K_SPACE) && count%3 == 0
      bullets2 << Bullet.new(player.x, player.y)
  end

  bullets2.each do |bullet2|
    bullet2.move
  end

  bullets1.each do |bullet1|
    bullet1.move
  end

  Sprite.draw(enemies)
  Sprite.draw(enemies2)
  Window.draw_font(10, 10, "スコア：#{player.score}", font) # 追加
  Window.draw_font(500, 10, "HP：#{player.hp}/5", font) # 追加

  Sprite.check(player, enemies)
  Sprite.check(player, enemies2)

  if player.dead_flag == 1
    break
  end

  count += 1

end

Window.update

Window.loop do
    Window.draw_font(Window.width/2-150, Window.height/2 - 50 , "Game Over...", fontL)
    Window.draw_font(Window.width/2-50, Window.height/2 + 20 , "Continue?", font)


end