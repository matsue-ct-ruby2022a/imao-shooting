require 'dxruby'

x = 100 
y = 300
n = 0
i = 2

image = Image.load("image/airplane.png")

class Sprite
attr_reader :n
    def initialize(set)
        self.x = X
        self.y = y
        @n = 1
    end
    def move
        
        if(x <= 10 )
            n = 1
        end
        if( x >= 400)
            n = 0
        end
        if(Input.key_down?(K_SPACE) && x <= 10 )
            n = 0
        end
        if(Input.key_down?(K_SPACE) &&  x >= 400)
            n = 1
        end
          
        if(n == 0)
            if(Input.key_down?(K_SPACE))
                x = x + i 
            else
                x = x - i 
            end
        end
        if(n == 1)
            if(Input.key_down?(K_SPACE))
                x = x - i 
            else
                x = x + i 
            end
        end

    end
end

Window.loop do
    Sprite.move

    Window.draw(self.X, self.y, image)
end