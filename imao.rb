class Imao < Sprite
    attr_accessor :a
    @a = 0
    if @a == 0
        def update
            self.x += 3
            if self.x >= 645
                @a = 1
            end
        end
    end
end