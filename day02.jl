input = readlines("day02-input.txt")

# Starting position
global pos = [2 2]
global combo = []

function numpad_move(position, direction)
    
    moves = Dict(
    "D" => [ 0  1],
    "U" => [ 0 -1],
    "L" => [-1  0],
    "R" => [ 1  0],
    )
    
    direction = string(direction)  
    move_vec = moves[direction]    # Translate direction into vector
    position = position + move_vec # Adjust position
    
    # If we moved off the numpad, return to it
    position[position .> 3] .= 3
    position[position .< 1] .= 1
    
    return position
end

function numpad_lookup(position)
    numpad = [1 2 3; 4 5 6; 7 8 9]
    return(numpad[position[2], position[1]])
end


for line in input
    for letter in line
        global pos = numpad_move(pos, letter)
    end    
    push!(combo, numpad_lookup(pos))
end

print(combo)


# Part 2 ----------



function numpad_lookup2(position)
    
    # If we're off the grid, return missing
    if any(position .< 1)
        return(missing)
    elseif any(position .> 5)
        return(missing)
    end

    X = missing
    
    numpad = [
    X  X   1   X  X;
    X  2   3   4  X;
    5  6   7   8  9;
    X 'A' 'B' 'C' X; 
    X  X  'D'  X  X;
    ]
    
    return(numpad[position[2], position[1]])
end

function numpad_move2(position, direction)
    
    moves = Dict(
    "D" => [ 0  1],
    "U" => [ 0 -1],
    "L" => [-1  0],
    "R" => [ 1  0],
    )
    
    direction = string(direction)
    move_vec = moves[direction]    # Translate direction into vector
    new_position = position + move_vec # Find new position
    
    # If the new position is missing, return the old position
    if ismissing(numpad_lookup2(new_position))
        return position
    else
        return new_position
    end
end


# Starting position
global pos = [1 3]  # Still start at 5
global combo = []

for line in input
    for letter in line
        global pos = numpad_move2(pos, letter)
    end    
    push!(combo, numpad_lookup2(pos))
end

print(combo)