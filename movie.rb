require 'dxruby'
require_relative 'imao'

black = Sprite.new(0, 0, Image.load( "image/black.png"))
ap1 = Sprite.new(100, 300, Image.load( "image/ap1.png"))
ap2 = Sprite.new(250, 300, Image.load( "image/ap2.png"))
ap3 = Sprite.new(400, 300, Image.load( "image/ap3.png"))
imao = Imao.new(0, 300, Image.load( "image/imao.png"))

map_font = Font.new(35); font = Font.new(35)

Window.loop do

    black.draw
    ap1.draw
    ap2.draw
    ap3.draw
    imao.update
    imao.draw

    case imao
        when ap1
            Window.draw_font(220, 420, "僕は今尾です", font, z:2)
        when ap2
            Window.draw_font(220, 420, "退職します", font, z:2)
        when ap3
            Window.draw_font(220, 420, "ありがとうございました", font, z:2)
    end
    if imao.a == 1
        break
    end
end