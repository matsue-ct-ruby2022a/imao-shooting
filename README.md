#　シューティングのりどみ
#--------------------------------------
#プレーヤー
#--------------------------------------
class Player < SRtask
	def init()
#プレーヤー画像
		@img=load_cg("cg/player.png")
#タイプをセット（当たり判定用）
		set_type(:player)
	end
#move()は１フレームに一回呼ばれる
	def move()
#テンキーの番号で入力の方向を表す
#4は左 6は右
		if $joy.is?(IN_4)
			@pos.x-=12
		elsif $joy.is?(IN_6)
			@pos.x+=12
		end

		@pos.x=16 if @pos.x<16
		@pos.x=640-16 if @pos.x>640-16
		@pos.y=16 if @pos.y<16
		@pos.y=480-16 if @pos.y>480-16

#Aボタン（キーボードだとzキー）が押されたか？
		if $joy.down?(IN_a)
			t=Tama.new(@pos.x,@pos.y)
		end
	end
#当たった時に呼ばれる
	def on_bomb()
	end
end
#--------------------------------------
#自機の弾
#--------------------------------------
class Tama < SRtask
	def init()
		@img=load_cg("cg/tama.png")
		set_type(:tama)
	end
#move()は１フレームに一回呼ばれる
	def move()
		@pos.y-=16
		stop if @pos.y<-32
	end
#当たった時に呼ばれる
	def on_bomb()
		stop
	end
end
#--------------------------------------
#爆発パターン
#--------------------------------------
class Bomb < SRtask
	def init()
		@img=load_cg("cg/bomb.png")
	end
#move()は１フレームに一回呼ばれる
	def move()
		stop if @timer>30
	end
end
#--------------------------------------
#敵の弾
#--------------------------------------
class Etama < SRtask
	def init()
		@img=load_cg("cg/etama.png")
		set_type(:etama)
	end
#move()は１フレームに一回呼ばれる
	def move()
		@pos.y+=16
		stop if @pos.y>500
	end
	def on_bomb()
		stop
	end
end
#--------------------------------------
#敵
#--------------------------------------
class Enemy < SRtask
	def init()
		@live=true
		@img=load_cg("cg/enemy.png")
		@speed=4
		@dir=-@speed
		set_type(:enemy)
	end
	def live?()
		@live
	end
#move()は１フレームに一回呼ばれる
	def move()
		@pos.x+=@dir
		if @pos.x<16
			@pos.x=16
			@dir=@speed
		end
		if @pos.x>640-16
			@pos.x=640-16
			@dir=-@speed
		end
		if @timer%30==0
			t=Etama.new(@pos.x,@pos.y)
		end
	end
	def on_bomb()
		@live=false
		b=Bomb.new(@pos.x,@pos.y)
		stop
	end
end

#--------------------------------------
#アプリケーション
#--------------------------------------
class Gameapp < SRapp
	def init()
		@pl=Player.new(240,400)
		@e=Enemy.new(320,50)
	end
#move()は１フレームに一回呼ばれる
	def move()
		if !@e.live?
			@e=Enemy.new(320,50)
		end
#当たり判定
#自機と敵の弾
		SRtask.hit_check(:player,:etama)
#自機と敵
		SRtask.hit_check(:player,:enemy)
#敵と自機の弾
		SRtask.hit_check(:enemy,:tama)
	end
	def draw()
	end
end