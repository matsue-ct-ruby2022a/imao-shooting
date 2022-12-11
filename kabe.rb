require 'dxruby'

x = 0
y = 0
image = Image.load("yama.png")

Window.loop do
  x = x + 3
  y = y + Input.y
  Window.draw(x, y, image)
  Window.draw(x+600, y, image)
  Window.draw(x-600, y, image)
  x = x - 600 if(x >= 600)
end