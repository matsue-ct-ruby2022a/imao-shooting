require 'dxruby'

require_relative 'Map'
require_relative 'player'
require_relative 'enemy'
require_relative 'enemy2'
require_relative 'bullet'
require_relative 'imao'


font = Font.new(32) # 追加
fontL = Font.new(64) # 追加
map_font = Font.new(35); font = Font.new(35)#movie用



#画像
player_img = Image.load("image/imao.png")
enemy_img = Image.load("image/enemy.png")
enemy2_img = Image.load("image/enemy2.png")
BULLET_IMG = Image.load('image/enemyshot1.png')
title = Sprite.new(0, 0, Image.load( "image/title.png"))
start = Sprite.new(248, 300, Image.load( "image/start.png"))
movie = Sprite.new(248, 230, Image.load( "image/movie.png"))


#movie
black = Sprite.new(0, 0, Image.load( "image/black1.png"))
ap1 = Sprite.new(100, 300, Image.load( "image/ap1.png"))
ap2 = Sprite.new(250, 300, Image.load( "image/ap2.png"))
ap3 = Sprite.new(400, 300, Image.load( "image/ap3.png"))
imao = Imao.new(0, 300, Image.load( "image/imao.png"))

#アイテム
z = []
z.push(Image.load("image/megane.png")) #pixnoteで作成
z.push(Image.load("image/kyokasho.png"))
z.push(Image.load("image/head.png"))
z.push(Image.load("image/bakuhatsu.png"))
z.push(Image.load("image/dogo1.png"))
z.push(Image.load("image/kaminari.png"))
z.push(Image.load("image/imao.png"))

#背景
m = []
m.push(Image.new(32, 32, [120, 210, 200]))
m.push(Image.new(32, 32, [255, 255, 255]))
m.push(Image.load("image/kabe.png"))
m.push(Image.load("image/kabe2.png"))
m.push(Image.load("image/kabe3.png"))
m.push(Image.load("image/kabe4.png"))

map2 = Map.new("map1.dat", m, rt=RenderTarget.new(640,480)) #背景

#背景の座標
x = 0
y = 0

#各種パラメータ
count = 0
n = 30
dead_flag = 0
start_flag = 0
movie_flag = 0
continue_flag = 1

player1 = Player.new(320, 400, player_img) 
player2 = Player.new(320, 100, player_img) 
mouse = Sprite.new(0, 0, Image.new(10, 10, C_WHITE)) #マウス
enemies = [] #敵1
enemies2 = [] #敵2
p1_bullets1 = [] #弾
p1_bullets2 = [] #弾
p2_bullets1 = [] #弾
p2_bullets2 = [] #弾
e=[]#アイテム表示用


Window.loop do

    if start_flag == 0 and movie_flag == 0

      mouse.x, mouse.y = Input.mouse_x, Input.mouse_y#マウスの位置を取得
      title.draw#タイトル画像の描画
      start.draw#startボタンの表示
      movie.draw#movieボタンの表示

      case mouse
          when start
              if Input.mouse_push?(M_LBUTTON)
                  start_flag = 1 #
              end
          when movie
            if Input.mouse_push?(M_LBUTTON)
                if imao.a == 1
                    imao = Imao.new(0, 300, Image.load( "image/imao.png"))
                    movie_flag = 1
                end
                movie_flag = 1
            end    
      end

    elsif start_flag == 1

      if player1.dead_flag == 0

        map2.draw(x, -y)
        Window.draw(0, 0, rt)

        if y%30==0
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
          Sprite.check(player1, e[i])
          Sprite.check(player2, e[i])
        end

        player1.draw
        player1.move1

        player2.draw
        player2.move2

        if Input.key_push?(K_SPACE)

            p1_bullets1 << Bullet.new(player1.x, player1.y)

        # elsif Input.key_down?(K_SPACE) && count%5 == 0
        #     p1_bullets2 << Bullet.new(player1.x, player1.y)
        end

        # p1_bullets2.each do |bullet2|
        #   bullet2.move1
        # end

        p1_bullets1.each do |bullet1|
          bullet1.move1
        end
        
        if Input.key_push?(K_LSHIFT)

          p2_bullets1 << Bullet.new(player2.x, player2.y)

        # elsif Input.key_down?(K_LSHIFT) && count%5 == 0
        #     p2_bullets2 << Bullet.new(player2.x, player2.y)
        end

        # p2_bullets2.each do |bullet2|
        #   bullet2.move2
        # end

        p2_bullets1.each do |bullet1|
          bullet1.move2
        end

        col1 = player1.hp <= 50 ? [255,0,0] : [0,255,0]
        col2 = player2.hp <= 50 ? [255,0,0] : [0,255,0]
        
        Window.draw_font(10, 10, "HP：#{player2.hp}/100", font, {color:col2}) # 追加
        Window.draw_font(450, 10, "HP：#{player1.hp}/100", font, {color:col1}) # 追加

        # Sprite.check(player, enemies)
        # Sprite.check(player, enemies2)
        # Sprite.check(bullets1, enemies)
        # Sprite.check(bullets2, enemies)
        # Sprite.check(bullets1, enemies2)
        # Sprite.check(bullets2, enemies2)

        count += 1 # 弾連射用
        y += 1

        if Input.keyDown?( K_B )
          break
        end
        
      elsif player1.dead_flag == 1
        
        Window.draw_font(Window.width/2-150, Window.height/2 - 50 , "Game Over...", fontL)
        Window.draw_font(Window.width/2-50, Window.height/2 + 20 , "Continue?", font)
        Window.draw_font(Window.width/2-100, Window.height/2 + 60 , "Yes: Press A key", font)
        Window.draw_font(Window.width/2-100, Window.height/2 + 95 , " No: Press S key", font)

        if Input.keyDown?( K_A )
          start_flag = 0
          player1.dead_flag = 0
          player1.hp = 100
        elsif Input.keyDown?( K_S )
          break
        end  

      end

    elsif movie_flag == 1

        black.draw
        ap1.draw
        ap2.draw
        ap3.draw
        imao.update
        imao.draw

        case imao
            when ap1
                Window.draw_font(220, 200, "僕は今尾です", font, z:2)
            when ap2
                Window.draw_font(220, 200, "退職します", font, z:2)
            when ap3
                Window.draw_font(220, 200, "ありがとうございました", font, z:2)
        end

        if imao.a == 1
            movie_flag = 0
        end

    end

end