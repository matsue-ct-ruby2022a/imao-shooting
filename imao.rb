class Imao < Sprite
    attr_accessor :a
    @a = 0
    if @a == 0
        def update
<<<<<<< HEAD
            self.x += 0.8
=======
            self.x += 0.3
>>>>>>> b3336cc00891c192506b6bff5fbd404deee183c2
            if self.x >= 640
                @a = 1
            end
        end
    end
end