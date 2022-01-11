input = readlines("day03-input.txt")

global valid = []  # Array of valid triangles

# Check if a triangle is valid based on the length of sides
function is_valid_triangle(sides)
    longest = maximum(sides)  # Find the longest side
    
    # Find the index of the longest side
    # We use first() to handle edge cases where there are two sides with the same length
    longest_index = first(findall(x-> (x == longest), sides)) 
    
    # The sides that are not the longest side
    not_longest = sides[1:end .!= longest_index]
    
    return sum(not_longest) > longest
end

for line in input
    
    sides = map(x -> parse(Int, strip(x)), split(line))  # Parse text
           
    if is_valid_triangle(sides)
        push!(valid, sides)
    end
end

print("Part 1: ", length(valid), '\n')

# Part 2 -------

using DelimitedFiles

input = readdlm("day03-input.txt")
rows = size(input)[1]

# The "first line" for parsing each triangle
first_lines = [1:3:rows;]

# An array of the sides to check
global sides = []

# Rejig the triplets columnwise
for start in first_lines
    for i in 1:3
        push!(sides, [input[start, i], input[start+1, i], input[start+2, i]])
    end
end

# An array of valid triangles
valid = []

for side in sides
    if is_valid_triangle(side)
        push!(valid, side)
    end
end

print("Part 1: ", length(valid), '\n')
