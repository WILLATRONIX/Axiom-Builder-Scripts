$once$

block = $blockState(Block)$

angleXY = math.rad($int(XZ Angle,45,0,360)$)
angleY = math.rad($int(Y Angle,45,0,360)$)

lengthMax = $int(Length,20,0,64)$
randomLengthOffset = $int(Random Length Offset,0,0,20)$

maxSize = $float(Start Size,2.5,0.1,8)$
minSize = $float(End Size,0.5,0.1,8)$

cluster = $boolean(Generate Cluster,false)$
clusterAmount = $int(Cluster Amount,3,1,8)$
randomiseClusterAmount=$boolean(Randomise Cluster Amount (Uses 'Cluster Amount' as the limit))$

clusterXZRangeMax=$int(Cluster Random XZ Range Max,0,0,360)$
clusterXZRangeMin=$int(Cluster Random XZ Range Min,360,0,360)$
clusterYRangeMax=$int(Cluster Random Y Range Max,30,0,360)$
clusterYRangeMin=$int(Cluster Random Y Range Min,150,0,360)$

if randomiseClusterAmount then
	clusterAmount=math.floor(math.random(1,clusterAmount))
end

local function setBlockWithSize(x, y, z, size)
    local radius = size
    for dx = -radius, radius do
        for dy = -radius, radius do
            for dz = -radius, radius do
                if dx * dx + dy * dy + dz * dz <= radius * radius then
                    setBlock(x + dx, y + dy, z + dz, block)
                end
            end
        end
    end
end

for spike=1, clusterAmount do
	if cluster then
	    angleXY = math.rad(math.random(clusterXZRangeMax,clusterXZRangeMin))
		angleY = math.rad(math.random(clusterYRangeMax,clusterYRangeMin))
	end
	lengthMax = lengthMax+math.floor(math.random(randomLengthOffset*-1,randomLengthOffset))
	for length=0, lengthMax do
		local xv = x + length * math.cos(angleY) * math.cos(angleXY)
		local zv = z + length * math.cos(angleY) * math.sin(angleXY)
		local yv = y + length * math.sin(angleY)
        local size = minSize + (maxSize - minSize) * (1 - length / lengthMax)
        setBlockWithSize(xv, yv, zv, size)
	end
end

