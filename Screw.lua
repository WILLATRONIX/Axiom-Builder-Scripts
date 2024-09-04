$once$

block=$blockState(Block)$

height=$int(Screw Height,50,0,100)$
radius=$int(Screw Radius,20,0,100)$
rotation=$int(Screw Rotation,60,0,100)$
scaleXZ=$int(Line XZ Scale,5,0,100)$
scaleY=$int(Line Y Scale,5,0,100)$

for distX = 0, scaleXZ-1 do
    for distY = 0, height-1 do
        for distZ = 0, scaleXZ do
			for distA = 0, scaleY-1 do
	        	setBlock(x + math.floor(distX+math.cos((rotation / height) * ((height*0.001) * math.pi * distY)) * radius), y+distY+distA+1, z + math.floor(distZ+math.sin((rotation / height) * ((height*0.001) * math.pi * distY)) * radius), block)
			end
        end
    end
end


