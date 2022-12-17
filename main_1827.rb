require 'dxruby'

require_relative 'Map'
require_relative 'player'
require_relative 'enemy'
require_relative 'enemy2'

font = Font.new(32)

z = []
z.push(Image.load("image/megane.png")) #pixnoteで作成
z.push(Image.load("image/kyokasho.png"))
z.push(Image.load("image/head.png"))
z.push(Image.load("image/bakuhatsu.png"))
z.push(Image.load("image/dogo1.png"))
z.push(Image.load("image/kaminari.png"))
z.push(Image.load("image/imao.png"))

m = []
m.push(Image.new(32, 32, [255, 0, 255]))
m.push(Image.new(32, 32, [255, 255, 255]))
m.push(Image.load("image/kabe.png"))
m.push(Image.load("image/kabe2.png"))
m.push(Image.load("image/kabe3.png"))
m.push(Image.load("image/kabe4.png"))

map2 = Map.new("map1.dat", m, rt=RenderTarget.new(640,480)) #背景

x = 0
y = 0

e=[]

player = Player.new(288, 300, z[6])

Window.loop do
    map2.draw(x, -y)
    Window.draw(0, 0, rt)

    if y%3==0
        v = z[rand(0..5)]
        if v==z[2]
            e.push(Enemy2.new(rand(0..608),-40,v))
        end
        if v==z[0] or v==z[1] or v==z[3] or v==z[4] or v==z[5]
            e.push(Enemy.new(rand(0..608),-40,v))
        end
    end
    
    e.size.times do |i|
        e[i].update
        Sprite.draw(e[i])
        Sprite.check(player, e[i])
    end

    player.move1
    player.draw

    if player.hp<=50
        col=[255,0,0]
    else
        col=[0,255,0]
    end

    Window.draw_font(10, 10, "HP:#{player.hp} score:#{player.score}",font, {color:col})
    y += 1
end