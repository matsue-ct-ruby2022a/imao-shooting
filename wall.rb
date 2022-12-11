require 'dxruby'

x = 0
y = 0
distance  = 400
image = Image.load("beam.jpg")

Window.loop do
  x = x + 3
  y = y + Input.y
  Window.draw(x, y, image)
  Window.draw(x+distance, y, image)
  Window.draw(x-distance, y, image)
  x = x - distance if(x >= distance)
end