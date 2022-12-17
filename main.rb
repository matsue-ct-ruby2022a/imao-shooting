require 'dxruby'

require_relative 'Map'
require_relative 'player'
require_relative 'enemy'
require_relative 'enemy2'
require_relative 'item1'
require_relative 'bullet'
require_relative 'imao'


font = Font.new(32) # 追加
fontL = Font.new(64) # 追加

map_font = Font.new(28); font = Font.new(28)#movie用

volume = 250
time = 0
Mcount = 0
Ncount = 0

bullet = Sound.new("voice/AnyConv.com__SNES-Shoot.wav")  # sound.wav読み込み
menusound = Sound.new("voice/ed.wav")  # bgm.mid読み込み
storysound = Sound.new("voice/iyana ziken dattane.wav")
sound = Sound.new('voice/Mystic Edge.wav')

bullet.set_volume(volume, time)
menusound.set_volume(volume, time)
storysound.set_volume(volume, time)
sound.set_volume(volume, time)

storysound.loop_count =(-1)
sound.loop_count =(-1)



#画像
player_img = Image.load("image/imao.png")
enemy_img = Image.load("image/enemy.png")
enemy2_img = Image.load("image/enemy2.png")
BULLET_IMG = Image.load('image/enemyshot1.png')
title = Sprite.new(0, 0, Image.load( "image/title.png"))

start = Sprite.new(248, 290, Image.load( "image/start.png"))
movie = Sprite.new(248, 230, Image.load( "image/movie.png"))
option = Sprite.new(253, 350, Image.load( "image/option.png"))


#movie
black = Sprite.new(0, 0, Image.load( "image/black1.png"))
imao = Imao.new(0, 300, Image.load( "image/black2.png"))
ap1 = Sprite.new(20, 300, Image.load( "image/black3.png"))
ap2 = Sprite.new(95, 300, Image.load( "image/black4.png"))
ap3 = Sprite.new(170, 300, Image.load( "image/black5.png"))
ap4 = Sprite.new(245, 300, Image.load( "image/black6.png"))
ap5 = Sprite.new(320, 300, Image.load( "image/black7.png"))
ap6 = Sprite.new(395, 300, Image.load( "image/black8.png"))
ap7 = Sprite.new(470, 300, Image.load( "image/black9.png"))
ap8 = Sprite.new(545, 300, Image.load( "image/black10.png"))

#option
title2 = Sprite.new(0, 0, Image.load( "image/title2.png"))
changescreen = Sprite.new(190, 220, Image.load("image/changescreen.png"))
fin = Sprite.new(280, 295, Image.load("image/fin.png"))
back = Sprite.new(280, 360, Image.load("image/back.png"))

#アイテム
z = []
z.push(Image.load("image/megane.png")) #pixnoteで作成
z.push(Image.load("image/kyokasho.png"))
z.push(Image.load("image/head.png"))
z.push(Image.load("image/kaminari.png"))
z.push(Image.load("image/dogo1.png"))
z.push(Image.load("image/bakuhatsu.png"))
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

#爆発
expl1 = nil
expl2 = nil

#背景の座標
x = 0
y = 0

#各種パラメータ
count = 0
ending_count = 0
n = 30
dead_flag = 0
start_flag = 0
movie_flag = 0
continue_flag = 1
option_flag = 0

player1 = Player.new(500, 300, player_img) 
player2 = Player.new(200, 300, player_img) 

mouse = Sprite.new(0, 0, Image.new(10, 10, C_WHITE)) #マウス
enemies = [] #敵1
enemies2 = [] #敵2
p1_bullets1 = [] #弾
p1_bullets2 = [] #弾
p2_bullets1 = [] #弾
p2_bullets2 = [] #弾

e=[]#アイテム表示用


def hp_judge(hp)

  if hp > 50
    col = [255,255,0]
  elsif hp <= 50 and hp > 25
    col = [0,255,0]
  else 
    col = [255,0,0]
  end

  return col

end



Window.loop do

    if start_flag == 0 and movie_flag == 0 and option_flag == 0

      if(Mcount==0)
        menusound.play
        Mcount = 1
      end
      
      mouse.x, mouse.y = Input.mouse_x, Input.mouse_y#マウスの位置を取得
      title.draw#タイトル画像の描画
      start.draw#startボタンの表示
      movie.draw#movieボタンの表示
      option.draw#optionボタンの表示

      case mouse
          when start
              if Input.mouse_push?(M_LBUTTON)
                  start_flag = 1 #

              end
          when movie
            if Input.mouse_push?(M_LBUTTON)
                if imao.a == 1

                    imao = Imao.new(0, 300, Image.load( "image/black2.png"))

                    movie_flag = 1
                end
                movie_flag = 1
            end
          when option
            if Input.mouse_push?(M_LBUTTON)
                option_flag = 1
            end    
      end

    elsif start_flag == 1

      if player1.dead_flag == 0 and player2.dead_flag == 0


        if(Ncount==0)
          sound.play
          Ncount = 1
        end
        map2.draw(x, -y)
        Window.draw(0, 0, rt)

        if y%30==0
          v = z[rand(0..4)]
          if v==z[2]
              e.push(Enemy2.new(rand(0..608),-40,v))
          elsif v==z[0] or v==z[1] or v==z[3]
              e.push(Enemy.new(rand(0..608),-40,v))
          elsif v==z[4]
            e.push(Item1.new(rand(0..608),-40,v))
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
        # enemies.each do |enemies|
        #   enemies.move
        # end

        col1 = hp_judge(player1.hp)
        col2 = hp_judge(player2.hp)

        
        
        Window.draw_font(10, 10, "HP：#{player2.hp}/50", font, {color:col2}) # 追加
        Window.draw_font(450, 10, "HP：#{player1.hp}/50", font, {color:col1}) # 追加

        Sprite.check(p1_bullets1, player2)
        Sprite.check(p2_bullets1, player1)

        y += 1

        if Input.keyDown?( K_B )
          break
        end
        
      elsif player1.dead_flag == 1 or player2.dead_flag == 1
        
        if ending_count < 100
          map2.draw(x, -y)
          Window.draw(0, 0, rt)

          if player1.dead_flag == 1

            if count == 0 
              expl1 = Sprite.new(player1.x, player1.y, z[5])
            end

            if count%10 == 0 or count%10 == 1 or count%10 == 2
              expl1.draw
            end

              player2.draw
              player2.move2

          elsif player2.dead_flag == 1

            if count == 0 
              expl2 = Sprite.new(player2.x, player2.y, z[5])
            end

            if count%10 == 0 or count%10 == 1 or count%10 == 2
              expl2.draw
            end

              player1.draw
              player1.move1

          end

          y += 0.3
          ending_count += 1
          count += 1
          
        else
          Window.draw_font(Window.width/2-150, Window.height/2 - 50 , "Game Over...", fontL)
          Window.draw_font(Window.width/2-50, Window.height/2 + 20 , "Continue?", font)
          Window.draw_font(Window.width/2-100, Window.height/2 + 60 , "Yes: Press A key", font)
          Window.draw_font(Window.width/2-100, Window.height/2 + 95 , " No: Press S key", font)

          if Input.keyDown?( K_A )

            e = []
            count = 0
            start_flag = 0
            ending_count= 0
            player1.dead_flag = 0
            player2.dead_flag = 0
            player1.hp = 50
            player2.hp = 50
            player1.x = 500
            player1.y = 300
            player2.x = 200
            player2.y = 300
            y = 0

          elsif Input.keyDown?( K_S )
            break
          end  

        end

      end

    elsif movie_flag == 1

        menusound.stop
        storysound.play
        black.draw
        ap1.draw
        ap2.draw
        ap3.draw
        ap4.draw
        ap5.draw
        ap6.draw
        ap7.draw
        ap8.draw
        imao.update
        imao.draw

        case imao

          when ap1
            Window.draw_font(230, 220, "----20XX年", font, z:2)
          when ap2
              Window.draw_font(110, 220, "数年前に問題を起こしたある教員が", font, z:2)
          when ap3
              Window.draw_font(150, 220, "松江高専を去ろうとしていた", font, z:2)
          when ap4
              Window.draw_font(85, 220, "彼は厳しくも優しい、伝説的な教員だった", font, z:2)
          when ap5
              Window.draw_font(132, 220, "彼をめぐり学生の意見は二分した", font, z:2)
          when ap6
              Window.draw_font(150, 195, "一方は彼を追い出そうとし、", font, z:2)
              Window.draw_font(150, 245, "もう一方は引き留めようとした", font, z:2)
          when ap7
              Window.draw_font(100, 220, "高専の未来を背負った二つの派閥の", font, z:2)
          when ap8
              Window.draw_font(145, 220, "仁義なき戦いが今、始まる----", font, z:2)

        end

        if imao.a == 1
            movie_flag = 0
            storysound.stop
            menusound.play
        end
    elsif option_flag == 1
      title2.draw
      changescreen.draw
      fin.draw
      back.draw

      case mouse
          when changescreen
                if Input.mouse_push?(M_LBUTTON)
                    #背景
                    m = []
                    m.push(Image.load("image/imao.png"))
                    m.push(Image.new(32, 32, [255, 255, 255]))
                    m.push(Image.load("image/kabe.png"))
                    m.push(Image.load("image/kabe2.png"))
                    m.push(Image.load("image/kabe3.png"))
                    m.push(Image.load("image/kabe4.png"))
                    map2 = Map.new("map1.dat", m, rt=RenderTarget.new(640,480))
                    option_flag = 0
                end
          when fin
                if Input.mouse_push?(M_LBUTTON)
                    break
                end
          when back
                if Input.mouse_push?(M_LBUTTON)
                    option_flag = 0
                end
            
        end
    end

end