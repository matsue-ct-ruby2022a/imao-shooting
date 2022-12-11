require 'dxruby'

#タイトル
Window.caption = ("imao-shooting")

#画像の読み込み
man = Sprite.new(65, 0, Image.load( "image/man.png"))
ap1 = Sprite.new(65, 380, Image.load("image/ap1.png"))
ap2 = Sprite.new(248, 380, Image.load("image/ap2.png"))
ap3 = Sprite.new(427, 380, Image.load("image/ap3.png"))

#マウスの作成
mouse = Sprite.new(0, 0, Image.new(10, 10, C_WHITE))

#フォントサイズ
map_font = Font.new(50); font = Font.new(50)

#描画ループ
Window.loop do
    #マウスの位置を取得
	mouse.x, mouse.y = Input.mouse_x, Input.mouse_y

    #マップの描画
	man.draw

	#難易度選択の描画
	ap1.draw; ap2.draw; ap3.draw;

    #各難易度にマウスが接触すると
	case mouse

        when ap1
            Window.draw_font(190, 265, "click to start", font, z:2)
            #easyモードをクリックした時
            if Input.mouse_push?(M_LBUTTON)
                require_relative 'main-easy'
            end
        when ap2
            Window.draw_font(190, 265, "click to start", font, z:2)
            #normalモードをクリックした時
            if Input.mouse_push?(M_LBUTTON)
                require_relative 'main-normal'
            end
        when ap3
            Window.draw_font(190, 265, "click to start", font, z:2)
            #hardモードをクリックした時
            if Input.mouse_push?(M_LBUTTON)
                require_relative 'main-hard'
            end

    end
    if Input.key_push?(K_ESCAPE) then
		break
	end
end

