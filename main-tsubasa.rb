require 'dxruby'

#画像の読み込み
title = Sprite.new(0, 0, Image.load( "image/title.png"))
start = Sprite.new(248, 290, Image.load( "image/start.png"))
movie = Sprite.new(248, 230, Image.load( "image/movie.png"))
option = Sprite.new(253, 350, Image.load( "image/option.png"))
man = Sprite.new(0, 0, Image.load( "image/man.png"))

#マウスの作成
mouse = Sprite.new(0, 0, Image.new(10, 10, C_WHITE))

#描画ループ
Window.loop do
    #マウスの位置を取得
	mouse.x, mouse.y = Input.mouse_x, Input.mouse_y

    #タイトル画像の描画
	title.draw

    #各ボタンの表示
    start.draw
    movie.draw
    option.draw

    case mouse
        when start
            if Input.mouse_push?(M_LBUTTON)
                require_relative 'level'
            end
        when movie
            if Input.mouse_push?(M_LBUTTON)
                man.draw
            end
        when option
            if Input.mouse_push?(M_LBUTTON)
                man.draw
            end
    end
    if Input.key_push?(K_ESCAPE) then
		break
	end
end