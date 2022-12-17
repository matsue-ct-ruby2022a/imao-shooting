require 'dxruby'

require_relative 'player'
require_relative 'enemy'
require_relative 'bullet'
require_relative 'imao'

# attr_accessor :movie_flag


font = Font.new(32) # 追加
fontL = Font.new(64) # 追加
map_font = Font.new(35); font = Font.new(35)#movie用

#画像読み込み
player_img = Image.load("image/player.png")
enemy_img = Image.load("image/enemy.png")
enemy2_img = Image.load("image/enemy2.png")
BULLET_IMG = Image.load('image/enemyshot1.png')
title = Sprite.new(0, 0, Image.load( "image/title.png"))
start = Sprite.new(248, 290, Image.load( "image/start.png"))
movie = Sprite.new(248, 230, Image.load( "image/movie.png"))

#movie用読み込み
black = Sprite.new(0, 0, Image.load( "image/black.png"))
ap1 = Sprite.new(100, 300, Image.load( "image/ap1.png"))
ap2 = Sprite.new(250, 300, Image.load( "image/ap2.png"))
ap3 = Sprite.new(400, 300, Image.load( "image/ap3.png"))
imao = Imao.new(0, 300, Image.load( "image/imao.png"))

count = 0
n = 100
dead_flag = 0
start_flag = 0
movie_flag = 0
continue_flag = 1

player = Player.new(100, 100, player_img) #自機
mouse = Sprite.new(0, 0, Image.new(10, 10, C_WHITE)) #マウス
enemies = [] #敵1
enemies2 = [] #敵2
bullets1 = [] #弾
bullets2 = [] #弾


Window.loop do


  # if continue_flag == 1
    if start_flag == 0 and movie_flag == 0

        mouse.x, mouse.y = Input.mouse_x, Input.mouse_y#マウスの位置を取得
        title.draw#タイトル画像の描画
        start.draw#startボタンの表示
        movie.draw#movieボタンの表示

        case mouse
            when start
                if Input.mouse_push?(M_LBUTTON)
                    start_flag = 1
                    n.times do #敵を表示
                        enemies << Enemy.new(rand(0..(640 - 32 - 1)), rand((480 - 32 - 1)), enemy_img)  # 敵描画
                        enemies2 << Enemy.new(rand(0..(640 - 32 - 1)), rand((480 - 32 - 1)), enemy2_img)  # 敵描画
                    end
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

  

        if player.dead_flag == 0
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

            count += 1

            if Input.keyDown?( K_B )
                break
            end
        
        elsif player.dead_flag == 1
        
            Window.draw_font(Window.width/2-150, Window.height/2 - 50 , "Game Over...", fontL)
            Window.draw_font(Window.width/2-50, Window.height/2 + 20 , "Continue?", font)
            Window.draw_font(Window.width/2-100, Window.height/2 + 60 , "Yes: Press A key", font)
            Window.draw_font(Window.width/2-100, Window.height/2 + 95 , " No: Press S key", font)

            if Input.keyDown?( K_A )
                start_flag = 0
                player.dead_flag = 0
                player.hp = 100
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
    # elsif continue_flag == 0
    #   break
    # end
    # end  

end