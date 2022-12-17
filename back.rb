require 'dxruby'

#画像データの読み出し
CASTLE = Image.load('image/castle.png')
FOREST = Image.load('image/forest.png')
MOUNTAIN = Image.load('image/mountain.png')
LAND = Image.load('image/land.png')
SPASE = Image.load('image/R.png')

wall = Image.load("image/rennga-2.jpe")

x = 0
y = 0
position_x = -64
position_y = 0
speed = 1
rout = 1

map = {:mep => [], :cave => []}
current_map = :mep
tile = {:mep => [LAND, FOREST, MOUNTAIN, CASTLE, SPASE]}

open('mep.txt') do |file|
  while l = file.gets
    map[:mep] << l.strip.split('')
  end
end


Window.loop do
  #背景スクロール
  y += speed
  Window.draw(x, y, wall)
  Window.draw(x, y+400, wall)
  Window.draw(x, y-400, wall)
  y -= 400 if(y >= 400)

  #壁生成
  24.times do |i|
    15.times do |j|
      Window.draw(i*32 + position_x, j*32 + position_y, tile[current_map][map[current_map][j][i].to_i])
      Window.draw(i*32 + position_x, j*32 + position_y-480, tile[current_map][map[current_map][j][i].to_i])
      position_y -= 480 if(position_y >= 480)
    end
  end
  position_y += speed
  rout = 1 if(position_x <= -128)
  rout = -1 if(position_x >= 0)
  position_x += rout
end