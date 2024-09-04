$once$
--Executes the script once per click

block = $blockState(block)$
--Determines the block to be used

lengthMin=$int(Min Cave Length,5000,0,10000)$
lengthMax=$int(Max Cave Length,10000,5000,15000)$
length = math.floor(math.random(lengthMin,10000))
--Sets the minimum and maximum length for the cave

stepSize = 1
offset = 14
mult = 0.1
--Try to avoid changing these settings as they can drastically affect the cave generation 

function getDirection(nx, ny, nz)
    local dx = 2 * getSimplexNoise(nx, ny, nz, 0) - 1
    local dy = 2 * getSimplexNoise(nx + 100, ny + 100, nz + 100, 0) - 1
    local dz = 2 * getSimplexNoise(nx + 200, ny + 200, nz + 200, 0) - 1
    return dx, dy, dz
end

function placeBlocksInRadius(x, y, z, radius, block)
	radii={0.5,1.5,2.5}
	radius=radii[math.floor(math.random(1,3))]
    for dx = -radius, radius do
        for dy = -radius, radius do
            for dz = -radius, radius do
                if dx * dx + dy * dy + dz * dz <= radius * radius then
                    setBlock(math.floor(x + dx), math.floor(y + dy), math.floor(z + dz), block)
                end
            end
        end
    end
end

for burgers = 1, length do
    if math.random() < 0.25 then
        local dx, dy, dz = getDirection(x * offset, y * offset, z * offset)
        local magnitude = math.sqrt(dx * dx + dy * dy + dz * dz)
        dx, dy, dz = dx / magnitude, dy / magnitude, dz / magnitude
        x = x + dx * stepSize
        y = y + dy * stepSize
        z = z + dz * stepSize
    else
        x = x + (math.random() * 2 - 1) * stepSize
        y = y + (math.random() * 2 - 1) * stepSize
        z = z + (math.random() * 2 - 1) * stepSize
    end
    placeBlocksInRadius(x, y, z, radius, block)
end


