require 'dxruby'


volume = 250
time = 0
Mcount = 0

bullet = Sound.new("voice/AnyConv.com__SNES-Shoot.wav")  # sound.wav読み込み
menusound = Sound.new("voice/ed.wav")  # bgm.mid読み込み
storysound = Sound.new("voice/iyana ziken dattane.wav")
sound = Sound.new('voice/Mystic Edge.wav')
#bgm.play
storysound.set_volume(volume, time)

storysound.loop_count=(-1)
Window.loop do
    if(Mcount==0)
        storysound.play
        Mcount = 1
    end
    if Input.key_push?(K_Z) then  # Zキーで再生
        storysound.stop
        #sound.play
    end

end