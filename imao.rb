class Imao < Sprite
    attr_accessor :a
    @a = 0
    if @a == 0
        def update

            self.x += 0.3

            if self.x >= 640
                @a = 1
            end
        end
    end
end