--This script creates a smooth 'bump' shape with many customisable features

centreX=$int(centreX,0,0,0)$
centreZ=$int(centreZ,0,0,0)$
--These two variables define the distribution centre

sigma_x=$int(Stretch X,10,0,30)$
sigma_y=$int(Stretch Y,10,0,30)$
sigma_z=$int(Stretch Z,10,0,30)$
--These three variables define the multiplier for each axis

noiseMultiplier=$int(Noise Multiplier,1,0,5)$
--Multiplies the noise by a given factor

noiseScale=$int(Noise Scale,8,2,12)$
--The noise scale determines how smooth the noise pattern should be

blockWidth=$int(Block Width,1,1,8)$
--Determines the size of each block. Allows for 3x3 cubes rather than a single block

block=$blockState(Block,stone)$
--The block to be placed

noise=((getSimplexNoise(x/noiseScale,y/noiseScale,z/noiseScale,0))*noiseMultiplier)
--Creates noise using noiseScale and noiseMultiplier with a seed of 0

gaussianDistribution=(math.exp(-(((x - centreX) ^ 2) / (2 * sigma_x ^ 2) + ((z - centreZ) ^ 2) / (2 * sigma_z ^ 2))))*(sigma_y*4)
--Creates a gaussian distribution using the provided coordinates and multipliers

height=noise*gaussianDistribution
--Creates a noise offset for the distribution

for distX = 0, blockWidth-1 do
    for distY = 0, height do
        for distZ = 0, blockWidth-1 do
			--These three loops above provide the needed function to work in a 3D environment.

			if x % blockWidth == 0 and z % blockWidth == 0 and getBlock(x,y,z)~=blocks.air then
				--Checks if the provided block size can fit into the coordinate

        		setBlock(x + distX, y + distY, z + distZ, block)
				--Places the block with the offset provided by the for loops
			end
        end
    end
end



