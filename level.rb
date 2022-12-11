require 'dxruby'

#タイトル
Window.caption = ("imao-shooting")

#画像の読み込み
mode = Sprite.new(0, 0, Image.load( "image/mode.png"))
easy = Sprite.new(255, 235, Image.load("image/easy.png"))
normal = Sprite.new(255, 295, Image.load("image/normal.png"))
hard = Sprite.new(258, 358, Image.load("image/hard.png"))

#マウスの作成
mouse = Sprite.new(0, 0, Image.new(10, 10, C_WHITE))

#フォントサイズ
map_font = Font.new(35); font = Font.new(35)

#描画ループ
Window.loop do
    #マウスの位置を取得
	mouse.x, mouse.y = Input.mouse_x, Input.mouse_y

    #マップの描画
	mode.draw

	#難易度選択の描画
	easy.draw; normal.draw; hard.draw;

    #各難易度にマウスが接触すると
	case mouse

        when easy
            Window.draw_font(220, 420, "click to start", font, z:2)
            #easyモードをクリックした時
            if Input.mouse_push?(M_LBUTTON)
                require_relative 'main-easy'
            end
        when normal
            Window.draw_font(220, 420, "click to start", font, z:2)
            #normalモードをクリックした時
            if Input.mouse_push?(M_LBUTTON)
                require_relative 'main-normal'
            end
        when hard
            Window.draw_font(220, 420, "click to start", font, z:2)
            #hardモードをクリックした時
            if Input.mouse_push?(M_LBUTTON)
                require_relative 'main-hard'
            end

    end
    if Input.key_push?(K_ESCAPE) then
		break
	end
end

