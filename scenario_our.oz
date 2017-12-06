local
   NoBomb=false|NoBomb
in
   scenario(bombLatency:3
	    walls:true
	    step: 0
	    snakes: [
		     snake(team:blue name:andres
			   positions: [pos(x:10 y:11 to:south) pos(x:10 y:10 to:south) pos(x:10 y:9 to:south) pos(x:10 y:8 to:south)  pos(x:10 y:7 to:south)  pos(x:10 y:6 to:south)]
			   effects: nil
			   strategy: [forward turn(right) repeat([forward] times:4) turn(right) repeat([forward] times:10)]
			   bombing: NoBomb
			  )
		     snake(team:green name:karolina
			   positions: [pos(x:12 y:13 to:east) pos(x:11 y:13 to:east) pos(x:10 y:13 to:east) pos(x:9 y:13 to:east) pos(x:8 y:13 to:east)]
			   effects: nil
			   strategy: [repeat([forward] times:6) turn(left) repeat([forward] times:6) repeat([forward] times:4)]
			   bombing: NoBomb
			  )
		     snake(team:yellow name:paul
			   positions: [pos(x:14 y:14 to:west) pos(x:15 y:14 to:west) pos(x:16 y:14 to:west) pos(x:17 y:14 to:west)]
			   effects: nil
			   strategy: [repeat([forward] times:7) turn(right) forward turn(left) repeat([forward] times:17)]
			   bombing: NoBomb
			  )
		      snake(team:black name:albert
			   positions: [pos(x:15 y:9 to:south) pos(x:15 y:10 to:south) pos(x:15 y:11 to:south) pos(x:15 y:12 to:south)]
			   effects: nil
			   strategy: [turn(right) turn(left) repeat([forward] times:7) forward turn(left) repeat([forward] times:6)]
			   bombing: NoBomb
			   )
		    ]
	    bonuses: [
		      bonus(position:pos(x:10 y:14) color:red effect:revert target:catcher)
		      bonus(position:pos(x:14 y:13) color:blue effect:shrink target:catcher)
		      bonus(position:pos(x:16 y:3) color:green effect:grow target:catcher)
		      bonus(position:pos(x:5 y:12) color:green effect:grow target:catcher)
		      bonus(position:pos(x:19 y:12) color:red effect:revert target:catcher)
		     ]
		bombs:nil
	   )
end