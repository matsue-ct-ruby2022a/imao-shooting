# マップ
class Map < Sprite
  attr_accessor :mapdata

  # targetは描画先のRenderTarget/Window
  def initialize(filename, mapimage, target=Window)
    @mapimage, @target = mapimage, target
    @mapdata = []
    File.open(filename, "rt") do |fh|
      lines = fh.readlines
      lines.each do |line|
        ary = []
        line.chomp.each_char do |o|
          if o != "x"
            ary << o.to_i
          else
            ary << nil
          end
        end
        @mapdata << ary
      end
    end
  end

  # x/yはマップ内の左上の座標(ピクセル表現)
  # 描画サイズは描画先(initializeのtarget)により自動的に調整される
  def draw(x, y)
    image = @mapimage[0]
    @target.draw_tile(0, 0, @mapdata, @mapimage, x, y,
    (@target.width + image.width - 1) / image.width,
    (@target.height + image.height - 1) / image.height)
  end
end