function isSurface(x,y,z)
    local surface = {
        {x = -1, y = 0, z = 0},
        {x = 1, y = 0, z = 0},
        {x = 0, y = -1, z = 0},
        {x = 0, y = 1, z = 0},
        {x = 0, y = 0, z = -1},
        {x = 0, y = 0, z = 1}
    }
    for _, coord in ipairs(surface) do
        local block = getBlock(x + coord.x, y + coord.y, z + coord.z)
        if block == blocks.air and getBlock(x,y,z)~=blocks.air then
            return true
        end
    end
    return false
end

blendFactor=$int(Blending Multiplier,8,1,16)$
blendSize=$int(Blending Radius,3,0,10)$
blendRangeMax=(blendSize*1)
blendRangeMin=(blendSize*-1)
invertPlacement=$boolean(Invert Placement,true)$

for blend = 1, blendFactor do
	randX=math.floor(math.random(blendRangeMin,blendRangeMax))
	randY=math.floor(math.random(blendRangeMin,blendRangeMax))
	randZ=math.floor(math.random(blendRangeMin,blendRangeMax))
	if isSolid(getBlock(x+randX,y+randY,z+randZ)) and isSurface(x+randX,y+randY,z+randZ) and isSurface(x,y,z) then 
		if invertPlacement then
			setBlock(x,y,z,getBlock(x+randX,y+randY,z+randZ))
		else
			setBlock(x+randX,y+randY,z+randZ,getBlock(x,y,z))
		end
	end
end


