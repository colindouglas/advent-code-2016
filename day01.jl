# Read, parse data
input = readline("day01-input.txt")
input = split(input, ", ")

# Turn with rotate matrices
turn_left(x)  = x * -[0 -1; 1 0]
turn_right(x) = x *  [0 -1; 1 0]

# Part 1 ------------------------

pos  = [0 0]
dir = [0 1]  # Start facing north

for instruct in input
    turn = SubString(instruct, 1, 1)
    mag = SubString(instruct, 2)

    turn = convert(String, turn)
    mag = parse(Int, mag)

    if turn == "R"
        global dir = turn_right(dir)
    elseif turn == "L"
        global dir = turn_left(dir)
    end
    global pos = pos + dir * mag
end

sum(map(abs, pos))

# Part 2 ----------------

using DataStructures

function find_overlap(input)

    local pos = [0 0]
    local dir = [0 1]  # Start facing north
    local locations = DefaultDict(0)


    for instruct in input
        turn = SubString(instruct, 1, 1)
        mag = SubString(instruct, 2)

        turn = convert(String, turn)
        mag = parse(Int, mag)

        if turn == "R"
            dir = turn_right(dir)
        elseif turn == "L"
            dir = turn_left(dir)
        end

        for _ in 1:mag
            # Move one block at a time
            pos = pos + dir

            # As we visit each location, mark that we've visited it
            locations[pos] = locations[pos] + 1

            # Check if we've visited this position previously
            # If we have, return the distance
            if any(map(x -> x > 1, values(locations)))
                distance = map(abs, pos)
                return(sum(distance))
            end
        end
    end
end

find_overlap(input)