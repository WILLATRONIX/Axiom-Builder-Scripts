-- IMPORTANT: USE THE SURFACE MASK
--                          FOR BETTER PERFORMANCE. 

range1=$int(Y Range 1,50,-64,319)$
range2=$int(Y Range 2,100,-64,319)$
smoothingMult=$float(Blending Amount,0,0,4)$
simplexScaleWidth=$int(Blending Width,1,1,50)$
simplexScaleHeight=$int(Blending Height,1,1,50)$
autoSmooth=true
rangeDiff=0

textureBlocks={
    {$blockState(Block 1     BASE   -,red_wool)$},
    {$blockState(Block 2                  -,orange_wool)$},
    {$blockState(Block 3                  -,yellow_wool)$},
    {$blockState(Block 4   MIDDLE -,lime_wool)$},
    {$blockState(Block 5                  -,green_wool)$},
    {$blockState(Block 6                  -,blue_wool)$},
    {$blockState(Block 7     PEAK   -,purple_wool)$},
	{getBlockState(x,y,z)},
}

if smoothingMult~=0 then
	for key=0, math.floor(smoothingMult/2) do
	    table.insert(textureBlocks,key+1,{getBlockState(x,y,z)})
	end
end

function blockPlacement()
	setBlock(x,y,z,withBlockProperty(textureBlocks[math.floor(math.max(1, math.min(#textureBlocks, math.floor(((y+math.floor(getSimplexNoise(x/simplexScaleWidth,y/simplexScaleHeight,z/simplexScaleWidth,0)*smoothing)) - range1) * (#textureBlocks-1) / (range2 - range1) + 1))))][1]))
end

function blockPlacementInverse()
	setBlock(x,y,z,withBlockProperty(textureBlocks[math.floor(math.max(1, math.min(#textureBlocks, math.floor(((y+math.floor(getSimplexNoise(x/simplexScaleWidth,y/(simplexScaleHeight),z/simplexScaleWidth,0)*smoothing)) - range2) * (#textureBlocks-1) / (range1 - range2) + 1))))][1]))
end

if range1<range2 and isSolid(getBlock(x,y,z)) then
	rangeDiff=range2-range1
	if y>=range1+(rangeDiff/#textureBlocks)+-(rangeDiff/#textureBlocks) and y<=range2-1 then
		if autoSmooth then
			smoothing=(math.floor(rangeDiff/#textureBlocks))*smoothingMult
		end
		blockPlacement()
	end

elseif range1>range2 and isSolid(getBlock(x,y,z)) then
	rangeDiff=range1-range2
	if y<=range1-1 and y>=range2+(rangeDiff/#textureBlocks)+-(rangeDiff/#textureBlocks) then
		if autoSmooth then
			smoothing=(math.floor(rangeDiff/#textureBlocks))*smoothingMult
		end
		blockPlacementInverse()
	end
end



