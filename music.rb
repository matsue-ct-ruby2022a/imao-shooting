require 'dxruby'


volume = 250
time = 10000

sound = Sound.new("voice/AnyConv.com__SNES-Shoot.wav")  # sound.wav読み込み
bgm = Sound.new("voice/ED.wav")  # bgm.mid読み込み

bgm.play
bgm.set_volume(volume, time)
bgm.set_volume(0 , time + 10000)
Window.loop do
    if Input.key_push?(K_Z) then  # Zキーで再生
        bgm.stop
        #sound.play
    end

end